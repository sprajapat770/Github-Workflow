#!/bin/sh -l

echo "Hello Suraj $1"
time=$(date)
echo "::set-output name=time::$time"
date="My date is My Date"
echo "::set-output name=date::$date"
