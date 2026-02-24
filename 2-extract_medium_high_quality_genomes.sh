#!/usr/bin/env bash

set -euo pipefail

QUALITY_DIR="/home/li69pej/animal_dental_calc/data_for_phage_analysis/genome_quality_checkv"
QUALITY_TSV="${QUALITY_DIR}/quality_summary.tsv"

FASTA_IN="/home/li69pej/animal_dental_calc/data_for_phage_analysis/phage_prediction_genomad/all_mammalian_oral_phages.fna"
FASTA_OUT="/home/li69pej/animal_dental_calc/data_for_phage_analysis/mammalian_oral_phages.fna"

TMP_IDS=$(mktemp)

echo "Reading quality table..."

# Extract contig IDs with desired CheckV quality
awk -F'\t' '
NR == 1 {
    for (i=1; i<=NF; i++) {
        if ($i == "contig_id") id_col=i
        if ($i == "checkv_quality") qual_col=i
    }
    next
}
{
    if ($qual_col == "Complete" ||
        $qual_col == "High-quality" ||
        $qual_col == "Medium-quality") {
        print $id_col
    }
}
' "$QUALITY_TSV" > "$TMP_IDS"

echo "Number of selected contigs:"
wc -l "$TMP_IDS"

echo "Extracting sequences..."

# Extract sequences from FASTA
awk '
BEGIN {
    while ((getline < "'"$TMP_IDS"'") > 0) ids[$1]=1
}
{
    if ($0 ~ /^>/) {
        header = substr($1, 2)
        keep = (header in ids)
    }
    if (keep) print
}
' "$FASTA_IN" > "$FASTA_OUT"

echo "Done."
echo "Output written to: $FASTA_OUT"

rm "$TMP_IDS"
