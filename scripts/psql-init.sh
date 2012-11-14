#! /usr/bin/env bash

echo RUN AS ROOT or fail
# just b/c you see `su` below doesn't mean you can run this as a normal user
su - postgres -c "psql -c 'drop database if exists eve;'"
su - postgres -c "psql -c 'create database eve;'"
