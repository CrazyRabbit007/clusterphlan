#!/bin/sh

#$ -o ~/sge-out
#$ -e ~/sge-out

export MODULEPATH=/users/k1639482/modules:$MODULEPATH

module load miniconda/localconda_A

metaphlandir=/users/k1639482/repos/metaphlan2/
dir=/users/k1639482/brc_scratch/STRAINS/

python ${metaphlandir}utils/merge_metaphlan_tables.py ${dir}sams/*.profile > ${dir}output/chinese_hmp_saliva_merged_abundance_table.txt
