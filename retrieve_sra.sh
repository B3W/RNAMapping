#!/bin/bash

module load sra-toolkit

while IFS='' read -r line || [[ -n "$line" ]]; do
    prefetch "$line"
done < "$1"
