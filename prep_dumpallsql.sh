#!/usr/bin/env bash

OUT_FILENAME=db_ears3_20230706.sql
IN_FILENAME=db_20230706.sql

echo "create user ears with password 'ears';" > $OUT_FILENAME
awk '/\\connect ears3/{f=1;next} f; /PostgreSQL database dump complete/{f=0}' $IN_FILENAME >> $OUT_FILENAME

echo "file $OUT_FILENAME created"