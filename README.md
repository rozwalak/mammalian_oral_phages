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

