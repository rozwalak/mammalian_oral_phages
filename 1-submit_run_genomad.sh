#!/bin/bash
BATCH_DIR="/home/li69pej/animal_dental_calc/data_for_phage_analysis/M1_contig_assemblies"
OUT_BASE="/home/li69pej/animal_dental_calc/data_for_phage_analysis/phage_prediction_genomad"

mkdir -p "${OUT_BASE}"

for fa in "${BATCH_DIR}"/*_final_contigs.fa.gz; do
    batch_name=$(basename "${fa}" _final_contigs.fa.gz)
    out_dir="${OUT_BASE}/${batch_name}"
    echo "Submitting job for ${batch_name}"
    sbatch run_genomad.sh "${fa}" "${out_dir}"
done
