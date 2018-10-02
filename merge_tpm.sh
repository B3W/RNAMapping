#!/bin/bash

# Check parameter
if [[ $# -ne 1 ]]; then
    echo "Must supply directory to work in as param"
    exit 1
fi

if [ ! -d "$1" ]; then
    echo "Unknown working directory"
    exit 1
fi

# Change working directory
pushd "$1"

# Cut all .tsv files and merge the results
echo "Cutting tsv files..."
for D in */; do
    dir_name="${D::-1}"
    cut -f 1,5 "$D""abundance.tsv" > "$dir_name""_tpm"
done

echo "Merging files..."
awk '{arr[$1]=arr[$1]"\t"$2}END{for(i in arr)print i,arr[i]}' *_tpm > "merged.tsv"

# Restore working directory
popd
