#!/bin/sh
chmod 777 repositories
svnadmin create "repositories/"$1
chmod 775 repositories
