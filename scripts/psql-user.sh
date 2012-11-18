#! /usr/bin/env bash

psql eve -c "create user goeve with encrypted password 'goeve';grant select on all tables in schema public to goeve;"