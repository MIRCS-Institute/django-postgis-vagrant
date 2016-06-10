#!/bin/bash
psql -U postgres < /vagrant/db/functions/database.sql
psql -U postgres -d mircs < /vagrant/db/functions/create_postgis_functions.sql
