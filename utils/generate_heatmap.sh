#!/bin/sh

#$ -cwd

#$ -l h_vmem=20G

export MODULEPATH=/users/k1639482/modules:$MODULEPATH

module load miniconda/localconda_A

metaphlandir=/users/k1639482/repos/metaphlan2/
dir=/users/k1639482/brc_scratch/STRAINS/

python ${metaphlandir}utils/metaphlan_hclust_heatmap.py -c bbcry --top 25 --tax_lev 's' --minv 0.1 -s log --in ${dir}output/chinese_hmp_saliva_merged_abundance_table.txt --out ${dir}output_images/chinese_hmp_saliva_species_top25_abundance_heatmap.png
