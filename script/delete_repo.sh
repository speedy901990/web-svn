#!/bin/sh
chmod 777 repositories
echo y | rm -R "repositories/"$1
chmod 775 repositories
