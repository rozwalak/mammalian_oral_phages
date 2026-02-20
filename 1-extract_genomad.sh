#!/bin/bash

# Set paths
INPUT_DIR="/home/li69pej/animal_dental_calc/data_for_phage_analysis/phage_prediction_genomad"
OUTPUT_DIR="/home/li69pej/animal_dental_calc/data_for_phage_analysis/phage_prediction_genomad"

# Output files
VIRUS_FNA="${OUTPUT_DIR}/all_mammalian_oral_phages.fna"
PLASMID_FNA="${OUTPUT_DIR}/all_mammalian_oral_plasmids.fna"
VIRUS_TSV="${OUTPUT_DIR}/all_mammalian_oral_virus_summary.tsv"
PLASMID_TSV="${OUTPUT_DIR}/all_mammalian_oral_plasmid_summary.tsv"

# Clear/init output files
> "$VIRUS_FNA"
> "$PLASMID_FNA"
> "$VIRUS_TSV"
> "$PLASMID_TSV"

# Header flags
VIRUS_HEADER_WRITTEN=false
PLASMID_HEADER_WRITTEN=false

# Loop over each sample subfolder
for SAMPLE_DIR in "${INPUT_DIR}"/*/; do
    SAMPLE=$(basename "$SAMPLE_DIR")

    SUMMARY_DIR="${SAMPLE_DIR}${SAMPLE}_final_contigs_summary"

    if [ ! -d "$SUMMARY_DIR" ]; then
        echo "WARNING: No summary dir found for $SAMPLE, skipping."
        continue
    fi

    VIRUS_FNA_IN="${SUMMARY_DIR}/${SAMPLE}_final_contigs_virus.fna"
    PLASMID_FNA_IN="${SUMMARY_DIR}/${SAMPLE}_final_contigs_plasmid.fna"
    VIRUS_TSV_IN="${SUMMARY_DIR}/${SAMPLE}_final_contigs_virus_summary.tsv"
    PLASMID_TSV_IN="${SUMMARY_DIR}/${SAMPLE}_final_contigs_plasmid_summary.tsv"

    # --- Process virus FASTA ---
    if [ -f "$VIRUS_FNA_IN" ]; then
        awk -v sample="$SAMPLE" '
            /^>/ { print ">" sample "_" substr($0, 2) }
            !/^>/ { print }
        ' "$VIRUS_FNA_IN" >> "$VIRUS_FNA"
        echo "  Processed virus FASTA: $SAMPLE"
    else
        echo "  WARNING: No virus FASTA for $SAMPLE"
    fi

    # --- Process plasmid FASTA ---
    if [ -f "$PLASMID_FNA_IN" ]; then
        awk -v sample="$SAMPLE" '
            /^>/ { print ">" sample "_" substr($0, 2) }
            !/^>/ { print }
        ' "$PLASMID_FNA_IN" >> "$PLASMID_FNA"
        echo "  Processed plasmid FASTA: $SAMPLE"
    else
        echo "  WARNING: No plasmid FASTA for $SAMPLE"
    fi

    # --- Process virus summary TSV ---
    if [ -f "$VIRUS_TSV_IN" ]; then
        if [ "$VIRUS_HEADER_WRITTEN" = false ]; then
            head -n 1 "$VIRUS_TSV_IN" >> "$VIRUS_TSV"
            VIRUS_HEADER_WRITTEN=true
        fi
        tail -n +2 "$VIRUS_TSV_IN" | awk -v sample="$SAMPLE" '
            BEGIN { OFS="\t" }
            NF > 0 {
                $1 = sample "_" $1
                print
            }
        ' >> "$VIRUS_TSV"
        echo "  Processed virus TSV: $SAMPLE"
    else
        echo "  WARNING: No virus TSV for $SAMPLE"
    fi

    # --- Process plasmid summary TSV ---
    if [ -f "$PLASMID_TSV_IN" ]; then
        if [ "$PLASMID_HEADER_WRITTEN" = false ]; then
            head -n 1 "$PLASMID_TSV_IN" >> "$PLASMID_TSV"
            PLASMID_HEADER_WRITTEN=true
        fi
        tail -n +2 "$PLASMID_TSV_IN" | awk -v sample="$SAMPLE" '
            BEGIN { OFS="\t" }
            NF > 0 {
                $1 = sample "_" $1
                print
            }
        ' >> "$PLASMID_TSV"
        echo "  Processed plasmid TSV: $SAMPLE"
    else
        echo "  WARNING: No plasmid TSV for $SAMPLE"
    fi

done

echo ""
echo "Done!"
echo "Virus FASTA:    $VIRUS_FNA"
echo "Plasmid FASTA:  $PLASMID_FNA"
echo "Virus TSV:      $VIRUS_TSV"
echo "Plasmid TSV:    $PLASMID_TSV"
