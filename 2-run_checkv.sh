#!/bin/bash
#SBATCH --job-name=checkv
#SBATCH --partition=standard
#SBATCH --ntasks=16
#SBATCH --mem=64GB
#SBATCH --time=08:00:00
#SBATCH --output=/home/li69pej/logs/checkv_%x_%j.out
#SBATCH --error=/home/li69pej/logs/checkv_%x_%j.err


source /vast/groups/VEO/tools/anaconda3/etc/profile.d/conda.sh && conda activate checkv_v1.0.1

FASTA="/home/li69pej/animal_dental_calc/data_for_phage_analysis/phage_prediction_genomad/all_mammalian_oral_phages.fna"
OUT_DIR="/home/li69pej/animal_dental_calc/data_for_phage_analysis/genome_quality_checkv/"
DB_DIR="/veodata/03/databases/checkv/v1.5"

checkv end_to_end "${FASTA}" "${OUT_DIR}" -d "${DB_DIR}" -t 16
