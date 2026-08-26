# Installation of the EARS server — RV Belgica

This is the installation document for the EARS server on RV Belgica.

## Deprecated / changed features

- **PostgreSQL runs on the host**, not inside a Docker container. A
  dedicated host-installed PostgreSQL 18 instance (Debian 13) is used, and
  the docker-compose stack is started in **`remote_db`** mode so it
  connects out to this host database instead of running its own.
- **TechSAS is obsolete and no longer used.** The old acquisition chain
  based on TechSAS UDP datagrams (POS/MET/TSS) has been retired.
  `ears3Nav` now reads directly from **MDM**, the main acquisition system,
  instead of ingesting TechSAS datagrams — there is no separate
  "acquisition server" component on this deployment.
- **The EARS desktop client is obsolete and no longer used.** Cruises and
  programs are populated through the `campaign-to-ears` import tool
  instead.

The rest of this document describes the current setup accordingly.

---

## Prerequisites

The main prerequisite is Linux with the Docker daemon installed. Installing
Docker, docker-compose, Git, fetching the EARS server files, and building an
image from the Dockerfile all require a fast and stable internet connection
(on-shore cable or 4G preferred over satellite). This is not always possible
on board, so plan the installation ahead. The server is a physical/virtual
Debian 13 host, accessible from the ship's LAN.

## Physical requirements

The PostgreSQL database lives on the host filesystem (via the native
`postgresql-18` package), separate from the Docker containers running the
web applications.

## Install PostgreSQL on the host

```
sudo apt update
sudo apt install -y curl ca-certificates gnupg
sudo apt install -y postgresql-common
sudo /usr/share/postgresql-common/pgdg/apt.postgresql.org.sh
sudo apt update
sudo apt install -y postgresql-18
psql --version
sudo systemctl status postgresql
sudo -u postgres psql -c "SELECT version();"
```

### Create the EARS schema

With the ears3-server repo checked out (see below), load the base DDL
directly against the host database as the `postgres` superuser:

```
sudo -u postgres psql -d ears3 -f ears_base_ddl.sql
```

(You must create the `ears3` database and the `ears` role beforehand if
they don't already exist — align the credentials with what's set in `.env`,
i.e. database `ears3`, user `ears`.)

### Allow the Docker containers to reach the host database

`pg_hba.conf` and `postgresql.conf` must be adjusted so the containers (on
the Docker bridge network) are permitted to connect to the host's Postgres
instance, and Postgres must be listening on an interface reachable from
that bridge network (not just `localhost`):

```
sudo nano /etc/postgresql/18/main/postgresql.conf   # listen_addresses, etc.
sudo nano /etc/postgresql/18/main/pg_hba.conf        # add docker bridge subnet
sudo systemctl restart postgresql
# or, for hba-only changes:
sudo systemctl reload postgresql
```

Useful checks while debugging connectivity:

```
sudo -u postgres psql -d ears3 -c "SHOW hba_file;"
sudo ss -tulpn | grep 5432
sudo tail -n 50 /var/log/postgresql/postgresql-18-main.log
```

Once configured, the database should be reachable from the host itself as:

```
psql -h localhost -U ears -d ears3 -c "SELECT * from public.cruise;"
```

## Install Docker (on physical or virtual machine)

Debian: follow the official Docker Engine install instructions
(`https://docs.docker.com/engine/install/debian/`):

```
sudo apt update
sudo apt install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

sudo tee /etc/apt/sources.list.d/docker.sources <<EOF
Types: deb
URIs: https://download.docker.com/linux/debian
Suites: $(. /etc/os-release && echo "$VERSION_CODENAME")
Components: stable
Architectures: $(dpkg --print-architecture)
Signed-By: /etc/apt/keyrings/docker.asc
EOF

sudo apt update
sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

Enable and start the daemon:

```
sudo systemctl enable docker.service
sudo systemctl enable containerd.service
sudo systemctl start docker.service
sudo systemctl status docker.service
```

Add the deployment user to the `docker` group (and, on this host, also to
`sudo`) so it doesn't need `sudo` for every Docker command, then re-login:

```
sudo usermod -a -G docker belgica
sudo usermod -a -G sudo belgica
exit   # log back in for group membership to take effect
```

`docker-compose` is provided by the `docker-compose-plugin` package
installed above (invoked as `docker compose`).

## Install git

```
sudo apt-get update
sudo apt-get install git
```

## Get the required files for the EARS server

The project lives under `/srv/docker`, owned by `belgica`:

```
sudo mkdir /srv/docker
sudo chown -R belgica:belgica /srv/docker
cd /srv/docker
git clone https://github.com/naturalsciences/ears3-server.git
cd ears3-server
git switch dev
```

This host tracks the **`dev`** branch. To update later, simply `git pull`
from within `ears3-server` — do not edit any tracked file other than
`.env`, since `.env` is the only file kept outside source control
(git-ignored) specifically so local configuration survives pulls.

## Configure the environment

`.env` is created once from the example file, then edited locally and left
untouched by future `git pull`s:

```
cp .env.example .env
nano .env
```

In `.env`, in addition to the usual settings (ports, `EARS_PLATFORM` C17
code for Belgica — see the NERC C17 vocabulary), make sure the database
connection settings match the host PostgreSQL instance and credentials
(database `ears3`, user `ears`), since the stack is started against a remote
(host) database rather than a bundled one.

## Create and run the docker containers — `remote_db` mode

```
cd /srv/docker/ears3-server
./run.sh remote_db
```

The compose file is configured with `restart: always`, so a reboot of the
host brings the whole stack back up automatically — no manual restart of
the containers is needed after a server restart.

Check container status and logs as usual:

```
sudo docker ps
sudo docker logs ears3-server-tomcat-remote
```

If you see a `org.postgresql.util.PSQLException: The connection attempt
failed.` in the Tomcat logs, this is almost always the host-side
`pg_hba.conf`/`postgresql.conf` configuration described above — revisit
those settings, reload/restart PostgreSQL, then re-run `./run.sh remote_db`.

Once running, wait at least a minute (the web server waits for the
database), then visit `http://localhost/ears3` (replacing `localhost` with
the server's actual IP where relevant) to confirm the application is up. A
set of REST endpoints under `/ears3Nav` (for the latest, nearest, and
between-dates navigation, meteorological, and thermosalinograph readings,
in XML, JSON, or raw datagram form) is also available.

## Addresses, ports and environment variables

The EARS webservices are reachable on `http://localhost` by default. Ports
can be changed in `.env`, though this is not recommended; prefer freeing
the port on the host (`sudo ss -tulpn | grep <port>`, then `sudo kill <pid>`
on the offending process) over remapping.

`EARS_PLATFORM` in `.env` must be set to the C17 (ICES) code for RV
Belgica — see `http://vocab.nerc.ac.uk/collection/C17/current/`.

## Usage

Go to `http://localhost/ears3/event` or simply `http://localhost/ears3` to
create new events. Programs and cruises are populated via the
`campaign-to-ears` import described below. In the web application you are
first prompted to provide your name and email address.

Go to `http://localhost/ears3/sml?platformUrn=SDN:C17::XYZA` to see the
Sensor ML description for the whole ship. Follow the links for the events
of specific devices.

Go to `http://localhost/ears3/api/cruise/csr?identifier=cruise_identifier`
to see the full SDN Cruise Summary Report.

## campaign-to-ears

`campaign-to-ears` imports programs and cruises from the SWAP ODNature
Belgica campaign tables into EARS. It depends on PostgreSQL, Docker, and
the main EARS application already being installed and running, since it
submits directly to the running EARS web application.

A JDK is required on the host; OpenJDK 21 is installed:

```
sudo apt update
sudo apt install -y openjdk-21-jdk
java --version
```

### Get the code / compile (optional — for building from source)

```
cd ~/dev
git clone https://gitlab.naturalsciences.be/bmdc/campaign-to-ears
mvn clean package
```

### Precompiled artifact

The deployed instance uses the precompiled jar and its config, placed
under `/opt/campaign-to-ears/`:

```
/opt/campaign-to-ears/
├── campaigntoears.jar
├── config.json
└── model/
    ├── xlm-roberta-base-ner-hrl.pt
    ├── config.json
    ├── serving.properties
    ├── tokenizer.json
    └── tokenizer_config.json
```

### Usage

```
java -jar campaigntoears.jar
    -s --server
    [-y --year]
    [-c --curl]
    [-j --json]
```

- `java -jar campaigntoears.jar --s http://<ears.address> --y current` —
  import the programs and cruises from last year, the current year and
  next year.
- `java -jar campaigntoears.jar --server http://<ears.address> --year 2016`
  — import the programs and cruises from 2016.
- `java -jar campaigntoears.jar --server http://<ears.address>` — import
  all programs and cruises.
- `java -jar target/campaigntoears.jar --server http://<ears.address> --year 2024 --curl`
  — dry run, output curl messages for quick submissions.
- `java -jar target/campaigntoears.jar --server http://<ears.address> --year 2024 --json`
  — dry run, output one big JSON object for all campaigns and programs.
- `java -jar target/campaigntoears.jar --server http://localhost --year 2024 --curl | grep curl > ~/post_ears_2024.sh`
  — dry run, output everything as a shell script.

In production, the tool is invoked as:

```
cd /opt/campaign-to-ears
java -jar campaigntoears.jar --s http://localhost --y current
```

### Configuration (config.json)

`config.json` must sit alongside the jar (the working directory must be
the jar's directory — no relative paths), and covers:

- **`harbourReplacements`** — maps harbour names to the C38 vocabulary.
- **`personReplacements`** — corrects personal names (e.g. `J.-M.` →
  `Jean-Marc`).
- **`persons2Edmo`** — maps persons to the EDMO code of the institute they
  worked for at a given point in time.
- **`emailPredictions`** — guesses EDMO codes from email addresses, and
  corrects email domains based on EDMO code. This has limits: a domain
  like `naturalsciences.be` can map to several EDMO codes. If exactly one
  match is found it's used and logged (and should then be added to
  `persons2Edmo`); if more than one match is found, no EDMO code is
  assigned, the resulting JSON is invalid for EARS, and the matches are
  logged so the correct one can be added to `persons2Edmo`.
- **`NER_MODEL_PATH_PT`** — path to the TorchScript build of the
  [XLM-RoBERTa NER model](https://huggingface.co/Davlan/xlm-roberta-base-ner-hrl/tree/main),
  set to `/opt/campaign-to-ears/model` on this deployment. The model
  directory must contain `config.json`, `serving.properties`,
  `tokenizer_config.json`, `tokenizer.json`, and
  `xlm-roberta-base-ner-hrl.pt`. It can be produced by running
  `djl-convert -m Davlan/xlm-roberta-base-ner-hrl -o pytorch`, or
  downloaded pre-built from the BMDC team SharePoint.

If imports don't show up as expected, check the Tomcat container logs (see
Troubleshooting) and re-check `config.json` before re-running the jar.

## Viewing the database

Connect directly to the host, rather than inspecting a container IP:

```
psql -h localhost -U ears -d ears3 -c "SELECT table_name FROM information_schema.tables WHERE table_schema='public' AND table_type='BASE TABLE';"
```

or, via a GUI:

```
sudo apt-get install postgresql-client
sudo apt-get install dbeaver-ce
```

Create a connection in DBeaver to `localhost`, port `5432` (or the port
PostgreSQL is actually listening on), database `ears3`, user `ears`.

Sample query once connected:

```
psql -h localhost -U ears -d ears3 -c "select * from public.cruise;"
```

## Data volumes

Do not delete the `ontologies` directory used by the containers. The
fastest way to save the vessel ontology is to put it in the `ontologies`
directory.

`ontologies/` is a bind-mounted directory shared between the host and the
Docker container, and the container writes to it as `root`. This can cause
permission errors (e.g. on `git pull`, if files under `ontologies/` are
tracked in git) when the host user tries to read, overwrite, or delete
files the container created. Fix existing ownership and make future writes
shared between the host user and the container by setting the group and
the setgid bit:

```
sudo chgrp -R belgica ontologies/
sudo chmod -R g+rwX ontologies/
sudo chmod g+s ontologies/
```

The setgid bit (`g+s`) makes new files and subdirectories created inside
`ontologies/` inherit the directory's group (`belgica`) instead of the
creating process's own group, so files the container writes as `root`
remain writable by the host user going forward. This does not retroactively
fix files created before the `chgrp`/`chmod` above, and does not propagate
to directories recreated from scratch by the container.

## Troubleshooting

Do not modify the `Dockerfile` or `docker-compose.yml` files. If any other
file (the WARs or `.env`) is changed, rebuild the image
(`sudo docker-compose build` / `docker compose build`) — or simply run
`./run.sh remote_db` again, which rebuilds only the affected layers.

Read the logs of the individual modules:

```
sudo docker logs ears3-server-tomcat-remote
```

If Tomcat can't reach the database (`PSQLException: The connection attempt
failed.`), this is a host-side firewall/`pg_hba.conf` issue — see "Allow
the Docker containers to reach the host database" above. As a last resort,
inspect the Docker bridge network configuration and confirm the container
can route to the host's Postgres address and port.

If you need to kill the Docker containers, e.g. after a Dockerfile change:

```
sudo docker kill ears3-server-tomcat-remote
```

## Coping with updates

If a new version of any web application (`ears3.war`, `ears3Nav.war`)
needs replacing:

- Ensure a stable and fast internet connection
- SSH to the server as `belgica`
- `cd /srv/docker/ears3-server`
- `git pull` (on the `dev` branch)
- `./run.sh remote_db`

The build command only rebuilds the steps affected by the change, so this
is faster than a full rebuild.