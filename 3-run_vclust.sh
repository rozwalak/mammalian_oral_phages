# wget https://github.com/refresh-bio/vclust/releases/download/v1.3.1/vclust-v1.3.1-x64_linux.tar.gz
# tar -xf vclust-v1.3.1-x64_linux.tar.gz

/home/li69pej/animal_dental_calc/data_for_phage_analysis/vclust-v1.3.1-x64_linux/vclust.py prefilter -i /home/li69pej/animal_dental_calc/data_for_phage_analysis/mammalian_oral_phages.fna -o fltr.txt --min-ident 0.70

/home/li69pej/animal_dental_calc/data_for_phage_analysis/vclust-v1.3.1-x64_linux/vclust.py align -i /home/li69pej/animal_dental_calc/data_for_phage_analysis/mammalian_oral_phages.fna -o ani.tsv --filter fltr.txt

/home/li69pej/animal_dental_calc/data_for_phage_analysis/vclust-v1.3.1-x64_linux/vclust.py cluster -i ani.tsv -o /home/li69pej/animal_dental_calc/data_for_phage_analysis/species_mammalian_oral_phages.tsv --ids ani.ids.tsv --algorithm leiden --metric ani --ani 0.95 --qcov 0.85

/home/li69pej/animal_dental_calc/data_for_phage_analysis/vclust-v1.3.1-x64_linux/vclust.py cluster -i ani.tsv -o /home/li69pej/animal_dental_calc/data_for_phage_analysis/genera_mammalian_oral_phages.tsv --ids ani.ids.tsv --algorithm leiden --metric ani --ani 0.70 --qcov 0.85
