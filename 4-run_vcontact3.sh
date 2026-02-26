#!/bin/bash
#SBATCH --job-name=vcontact3
#SBATCH --partition=standard
#SBATCH --ntasks=16
#SBATCH --mem=64GB
#SBATCH --time=08:00:00
#SBATCH --output=/home/li69pej/logs/vcontact3_%x_%j.out
#SBATCH --error=/home/li69pej/logs/vcontact3_%x_%j.err

source /vast/groups/VEO/tools/miniconda3_2024/etc/profile.d/conda.sh && conda activate vcontact3_3.0.5-0

FASTA="/home/li69pej/animal_dental_calc/data_for_phage_analysis/mammalian_oral_phages.fna"
OUT_DIR="/home/li69pej/animal_dental_calc/data_for_phage_analysis/mammalian_oral_phages_vcontact3/"
DB_DIR="/veodata/03/databases/vcontact3/v20250721" #RefSeq v.230

vcontact3 run --nucleotide "${FASTA}" --output "${OUT_DIR}" --threads 16 --exports cytoscape --db-path "${DB_DIR}"
