#!/bin/bash
psql -U postgres < /vagrant/db/functions/create_postgis_functions.sql
