#!/bin/sh
chmod 777 repositories
svnadmin create repositories/$1
rm repositories/$1/hooks/*
chmod 775 repositories
