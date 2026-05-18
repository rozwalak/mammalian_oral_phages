#!/bin/bash
#SBATCH --job-name=vclust
#SBATCH --partition=fat
#SBATCH --ntasks=2
#SBATCH --cpus-per-task=32
#SBATCH --mem=512GB
#SBATCH --time=48:00:00
#SBATCH --output=/home/li69pej/logs/vclust_databases_%x_%j.out
#SBATCH --error=/home/li69pej/logs/vclust_databases_%x_%j.err


# wget https://github.com/refresh-bio/vclust/releases/download/v1.3.1/vclust-v1.3.1-x64_linux.tar.gz
# tar -xf vclust-v1.3.1-x64_linux.tar.gz

# genomic sequences downloaded from https://www.meta-virome.org/Downloads and https://spire.embl.de/vire/downloads and concatenated with mammalian_oral_phages.fna into vire_metavr_mammalian_oral_phages.fna


/home/li69pej/animal_dental_calc/data_for_phage_analysis/vclust-v1.3.1-x64_linux/vclust.py prefilter -i /home/li69pej/animal_dental_calc/data_for_phage_analysis/vire_metavr_mammalian_oral_phages.fna -o /home/li69pej/animal_dental_calc/data_for_phage_analysis/fltr_metavr_vire.txt --min-ident 0.95 --batch-size 5000000 --kmers-fraction 0.2 -t 64

/home/li69pej/animal_dental_calc/data_for_phage_analysis/vclust-v1.3.1-x64_linux/vclust.py align -i /home/li69pej/animal_dental_calc/data_for_phage_analysis/vire_metavr_mammalian_oral_phages.fna -o /home/li69pej/animal_dental_calc/data_for_phage_analysis/ani_metavr_vire.tsv --filter /home/li69pej/animal_dental_calc/data_for_phage_analysis/fltr_metavr_vire.txt -t 64

/home/li69pej/animal_dental_calc/data_for_phage_analysis/vclust-v1.3.1-x64_linux/vclust.py cluster -i /home/li69pej/animal_dental_calc/data_for_phage_analysis/ani_metavr_vire.tsv -o /home/li69pej/animal_dental_calc/data_for_phage_analysis/species_metavr_vire_mammalian_oral_phages.tsv --ids /home/li69pej/animal_dental_calc/data_for_phage_analysis/ani_metavr_vire.ids.tsv --algorithm leiden --metric ani --ani 0.95 --qcov 0.85
