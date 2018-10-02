#!/bin/bash

# Check input directory
if [ ! -d "$1" ]; then
    echo "Unknown directory"
    exit 1
fi

# Get name for outdir
IFS='/' read -ra dir_name <<< "$1"
outdir="./fastq_files/""${dir_name[-1]}""/"

# Create directory if necessary
if [ ! -d "$outdir" ]; then
    mkdir "$outdir"
fi

# Convert sra files
module load sra-toolkit

if [[ ${1: -1} != "/" ]]; then
    
    for filename in "$1"/*.sra; do
	[ -e "$filename" ] || continue
	echo "Converting $filename to fastq format..."
	fastq-dump --outdir "$outdir" --split-files --origfmt --gzip "$filename"
    done

else

    for filename in "$1"*.sra; do
	[ -e "$filename" ] || continue
	echo "Converting $filename to fastq format..."
	fastq-dump --outdir "$outdir" --split-files --origfmt --gzip "$filename"
    done

fi
