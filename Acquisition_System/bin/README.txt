-------------------------------------------------------------------------------
                           Prototype d'acquisition
-------------------------------------------------------------------------------

  1. Delivery structure
  
    {root}
      README.txt
      startup.sh
      startup.bat
      conf/
        application.properties  -- properties used for configuration
        context.xml             -- instanciated components beans XML config file
        *.json                  -- other configuration data
      lib/
        *.jar                   -- all project generated JARs
        deps/
          *.jar                 -- all required thirdparty JARs
  
  2. Usage
  
    - Deploy the delivery on target server: just uncompress the archive in the
      desired location.
    
    - Customize the configuration on each server (default configuration
      implements an "all-in-a-box" setup) - see 4. Configuration
      
    - Run the application on each server (preferrably starting with the one
      hosting the broker):
      $ cd ${ACQUISITION_HOME}
      $ startup.sh acquisition          - acquisition-only server (without visualization services)
      $ startup.sh visualization        - archived data visualization-only server (without acquisition services)
      $ startup.sh all                  - all in one server (acquisition + visualization)

    - What you can see:
      * the test UI:
          http://<server>:8080/debug/index.html
      * the acquisition UI:
          http://<server>:8080/acquisition/index.html
          
      * the description service runs at:
          http://<server>:8080/description/<description_name>
          (default configuration only declares one named 'generic_gps')
      * each sample driver sends every second: a json message, a raw message
        (this can be seen in the logs)
      * the archive service listens to the first configuration message and
        subscribes to listed topics: each archive sub-service (netcdf and raw)
        then traces all incoming messages
      * configuration service sends a message every 20 seconds (configurable)
        with all sensors (currently based on a configuration file)
  
  3. Configuration
  
    application.properties:
    
      acquisition.description.enabled      -- should description service deploy here?
      acquisition.client.enabled           -- should client HTML deploy here?
      acquisition.broker.url               -- URL for the broker
      acquisition.configuration.fixedrate  -- configuration messages frequency
      acquisition.driver.fake.fixedrate    -- fake driver data messages frequency
      spring.main.web-environment          -- should the embedded web container run?
                                              (required only if either client or
                                              description runs)
    context.xml:
    
      - remove or comment out beans you don't want on this server
      - 2 fake driver instances are declared by default

    description.json:
    
      data used for description service
    
    configuration_mock_file.json:
    
      mock configuration data (should rely on drivers heartbeat eventually)
      
    frame_mock_file.json & raw_mock_file.json:
    
      mock data to be sent by the fake driver
      (note that the fake driver replaces the "time" field with current timestamp)
