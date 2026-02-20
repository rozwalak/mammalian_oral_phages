#!/bin/bash
#SBATCH --job-name=genomad
#SBATCH --partition=standard
#SBATCH --ntasks=8
#SBATCH --mem=12GB
#SBATCH --time=02:00:00
#SBATCH --output=/home/li69pej/logs/genomad_%x_%j.out
#SBATCH --error=/home/li69pej/logs/genomad_%x_%j.err

source /vast/groups/VEO/tools/miniconda3_2024/etc/profile.d/conda.sh && conda activate genNomad_v1.11.2

FASTA="$1"
OUT_DIR="$2"
DB_DIR="/veodata/03/databases/geNomad/v1.11.2/genomad_db"

mkdir -p "${OUT_DIR}"

echo "Input FASTA: ${FASTA}"
echo "Output dir:  ${OUT_DIR}"

genomad end-to-end --cleanup --splits 8 "${FASTA}" "${OUT_DIR}" "${DB_DIR}"
