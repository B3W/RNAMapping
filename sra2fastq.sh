#!/bin/bash

if [[ $# -eq 0 ]]; then
    echo "No filename supplied"
    exit 1
fi

if [[ ! -f $1 ]]; then
    echo "File not found!"
    exit 1
fi

if [[ ${1: -4} != ".sra" ]]; then
    echo "File extension must be .sra"
    exit 1
fi

module load sra-toolkit

echo "Converting $1 to fastq format..."
fastq-dump --outdir ./fastq_files --split-files --origfmt --gzip "$filename"

