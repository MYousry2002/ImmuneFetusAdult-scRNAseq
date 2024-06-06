#!/bin/bash

# Path to Cell Ranger executable
cellranger_path="$HOME/softwares/cellranger-8.0.1/cellranger"

# Path to the reference transcriptome
reference_transcriptome="$HOME/ImmuneFetusAdult-scRNAseq/reference_transcriptome/refdata-gex-GRCh38-2024-A"

# Directory containing the FASTQ files
fastq_dir="$HOME/ImmuneFetusAdult-scRNAseq/dataset/fetus/spleen"

# Output directory for Cell Ranger results
output_dir="$HOME/ImmuneFetusAdult-scRNAseq/aligned_quantified/fetus/spleen/"


declare -a sample_ids

# Dynamically find directories and construct sample entries
for sample_dir in $fastq_dir/*; do
    if [ -d "$sample_dir" ]; then
        sample_id=$(basename "$sample_dir")
        echo "Found sample directory: $sample_id"
        for err_dir in "$sample_dir"/*; do
            if [ -d "$err_dir" ]; then
                err_id=$(basename "$err_dir")
                echo "Found ERR directory: $err_id"
                # Extract actual sample name from the first FASTQ file
                fq_files=("$err_dir"/*.fastq.gz)
                if [ ${#fq_files[@]} -gt 0 ]; then
                    first_fq_file=$(basename "${fq_files[0]}")
                    actual_sample_name=$(echo "$first_fq_file" | cut -d '_' -f 1)
                    echo "Found sample name: $actual_sample_name"
                    sample_ids+=("$sample_id/$err_id/$actual_sample_name")
                    echo "Added to sample_ids: $sample_id/$err_id/$actual_sample_name"
                fi
            fi
        done
    fi
done

echo "Detected sample IDs: ${sample_ids[@]}"


# Run Cell Ranger
for sample in "${sample_ids[@]}"; do
    path_parts=(${sample//\// })  # Split string into array by '/'
    sample_id="${path_parts[0]}"  # SAMEA ID
    err_dir="${path_parts[1]}"  # ERR directory
    actual_sample_name="${path_parts[2]}"  # Actual sample name expected by Cell Ranger

    echo "Processing $sample_id..."
    $cellranger_path count --id="$sample_id" \
                           --transcriptome="$reference_transcriptome" \
                           --fastqs="$fastq_dir/$sample_id/$err_dir" \
                           --create-bam true \
                           --sample="$actual_sample_name" \
                           --localcores=20 \
                           --localmem=320
    echo "$sample_id processing complete."
done

echo "All samples have been processed."