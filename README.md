# Bacteriophages in mammalian dental calculus

### 1. Phage and plasmid identification

Phage and plasmid sequences were identified among 490 mammalian dental calculus and environmental control metagenomes using ([geNomad](https://github.com/apcamargo/genomad)) v1.11.2 

scripts: 1-run_genomad.sh + 1-submit_run_genomad.sh executing:
```
genomad end-to-end --cleanup --splits 8 INPUT OUTPUT DB
```
Next, using 1-extract_genomad.sh, we combined data to: 

- all_mammalian_oral_phages.fna (n = 121,823)

- all_mammalian_oral_plasmids.fna (n = 57,681)

- all_mammalian_oral_virus_summary.tsv

- all_mammalian_oral_plasmid_summary.tsv

### 2. Genome quality control

Phage genome quality control was estimated using ([CheckV](https://bitbucket.org/berkeleylab/checkv/src/master/)) v1.0.1 and 1.5 db version

script: 2-run_checkv.sh

```
checkv end_to_end all_mammalian_oral_phages.fna genome_quality_checkv -d DBv1.5 -t 16
```
CheckV genome summary: 

- Complete (n = 85)

- High quality (n = 210)

- Medium quality (n = 917)

- Low quality (n = 88,719)

- Not determined (n = 31,892)

Next, medium+ quality genomes (n = 1212) were extracted to mammalian_oral_phages.fna using 2-extract_medium_high_quality_genomes.sh

### 3. Genome clustering to vOTUs (species-like and genus-like groups)

According to Minimum Information about an Uncultivated Virus Genome ([MIUViG](https://www.nature.com/articles/nbt.4306)) 
viral operational taxonomic unit (vOTU) is a species-like group of sequences defined based on thresholds of 95% average nucleotide identity over 85% alignment fraction (relative to the shorter sequence).

According to the recommendation of the International Committee on Taxonomy of Viruses (ICTV) Subcommittee ([Turner et al.,2021](https://www.mdpi.com/1999-4915/13/3/506)), 70% nucleotide identity of the full genome length (tANI) is the cut-off for genera. Due to the fragmented nature of our phage genomes, we applied 70% ANI over 85% alignment fraction to cluster sequences into genus-like groups.

Genomes (mammalian_oral_phages.fna) were clustered using ([Vclust](https://github.com/refresh-bio/vclust)) v.1.3.1 implemented in script 3-run_vclust.sh

- species_mammalian_oral_phages.tsv (n clusters = 929)

- genera_mammalian_oral_phages.tsv (n clusters = 886)

### 4. Genome clustering to family-like groups (gene-sharing network)

For taxonomic classification and clustering to family-like groups, we used ([vContact3](https://vcontact3.readthedocs.io/en/latest/#)) implemented in the script 4-run_vcontact3.sh that executes the following command: 

```
vcontact3 run --nucleotide mammalian_oral_phages.fna --output mammalian_oral_phages_vcontact3 --threads 16 --exports cytoscape --db-path path/to/RefSeq230
```
Summary

Total input sequences: 1147

- 117 sequences (10.2%) belong to 12 KNOWN families (Naomviridae, Schitoviridae, Winoviridae, Autographiviridae, Peduoviridae, Casjensviridae, Orlajensenviridae, Aliceevansviridae, Rountreeviridae, Salasmaviridae, Inoviridae, Microviridae)

- 1030 sequences (89.8%) belong to 283 NOVEL families

### 5. Genome clustering with MetaVR and VIRE

To better understand the novelty of phage genomes in dental calculus, we clustered them with XXX genomes from MetaVR and XXX from the VIRE database. 

### 6. Host prediction

### 7. Summarizing results






