#!/bin/bash

# Path to Cell Ranger executable
cellranger_path="$HOME/softwares/cellranger-8.0.1/cellranger"

# Path to the reference transcriptome
reference_transcriptome="$HOME/ImmuneFetusAdult-scRNAseq/reference_transcriptome/refdata-gex-GRCh38-2024-A"

# Directory containing the FASTQ files
fastq_dir="$HOME/ImmuneFetusAdult-scRNAseq/dataset/fetus/thymus"

# Output directory for Cell Ranger results
output_dir="$HOME/ImmuneFetusAdult-scRNAseq/aligned_quantified/fetus/thymus/"

# Sample sheet with sample IDs
sample_ids=("SAMEA14357660/ERR9696953/FCAImmP7316898" "SAMEA14357661/ERR9696954/FCAImmP7316899" "SAMEA14357697/ERR9696989/FCAImmP7851896" "SAMEA14357698/ERR9696990/FCAImmP7851897")

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
                           --localcores=8 \
                           --localmem=128
    echo "$sample_id processing complete."
done

echo "All samples have been processed."