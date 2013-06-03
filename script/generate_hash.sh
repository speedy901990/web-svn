#!/bin/sh
htpasswd -nb $1 $2 | cut -d ":" -f2
