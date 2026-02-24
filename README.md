# Bacteriophages in mammalian dental calculus

### 1. Phage and plasmid identification

Phage and plasmid sequences were identified among 490 mammalian dental calculus and environmental control metagenomes using ([geNomad](https://github.com/apcamargo/genomad)) v1.11.2 

scripts: 1-run_genomad.sh + 1-submit_run_genomad.sh executing:
```
genomad end-to-end --cleanup --splits 8 INPUT OUTPUT DB
```
Next, using 1-extract_genomad.sh, we combined data to: 

-all_mammalian_oral_phages.fna (n = 121,823)

-all_mammalian_oral_plasmids.fna (n = 57,681)

-all_mammalian_oral_virus_summary.tsv

-all_mammalian_oral_plasmid_summary.tsv

### 2. Genome quality control

Phage genome quality control was estimated using ([CheckV](https://bitbucket.org/berkeleylab/checkv/src/master/)) v1.0.1 and 1.5 db version

script: 2-run_checkv.sh

```
checkv end_to_end all_mammalian_oral_phages.fna genome_quality_checkv -d DBv1.5 -t 16
```
CheckV genome summary: 

-Complete (n = 85)

-High quality (n = 210)

-Medium quality (n = 917)

-Low quality (n = 88,719)

-Not determined (n = 31,892)

Next, medium+ quality genomes (n = 1212) were extracted to mammalian_oral_phages.fna using 2-extract_medium_high_quality_genomes.sh

### 2. Genome clustering to vOTUs (species-like groups)
