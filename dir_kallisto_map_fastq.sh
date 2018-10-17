#!/bin/bash

# Check the input directory exists
if [ ! -d "$1" ]; then
    echo "Unknown input directory"
    exit 1
fi

# Normalize input directory name
indir="$1"
if [[ ${indir: -1} != "/" ]]; then
    indir="${1}/"
fi

# Scan directory for pairs of fastq files
acc_nums=()
for filename in "$indir"*.fastq.gz; do
    [ -e "$filename" ] || continue
    acc_nums+=("$filename")
done

# Complete kallisto mapping for each pair of fastq files
outdir="tpm_data/salmonella_enterica/"
echo
echo "Writing results to directory: ${outdir}"
indexed_file="./indexed_genome_cds/salmonella_enterica/salmonella_enterica_cds"
echo "Using indexed genome at: ${indexed_file}"
echo
for i in ${!acc_nums[@]}; do
     if [ $(($i % 2)) == 0 ]; then
	 # Show status update
	 echo "Mapping file pair:"
	 printf '\t%s\n' "${acc_nums[$i]}"
	 pair_index=$(($i+1))
	 printf '\t%s\n' "${acc_nums[$pair_index]}"
	 # Call subshell with kallisto mapping function
	 ( ./kallisto_map_fastq.sh "$outdir" "indexed_file" "${acc_nums[$i]}" "${acc_nums[$pair_index]}" )
     fi
     echo
done
echo
echo "Mapping complete!"
