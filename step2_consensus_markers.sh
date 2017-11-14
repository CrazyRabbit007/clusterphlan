#!/bin/sh

#$ -o ~/sge-out
#$ -e ~/sge-out

#$ -l h_vmem=10G
#$ -pe smp 20
#$ -R y

#$ -t 1-911
#$ -tc 10

export MODULEPATH=/users/k1639482/modules:$MODULEPATH

module load miniconda/localconda_A
module load strainphlan_src
module load samtools
module load bcftools

export PATH=/users/k1639482/repos/metaphlan2/strainphlan_src:$PATH

metaphlandir=/users/k1639482/repos/metaphlan2/
dir=/users/k1639482/brc_scratch/STRAINS/

bn=$(sed -n "${SGE_TASK_ID}p" ${dir}data/sambz2_names.txt)

python ${metaphlandir}strainphlan_src/sample2markers.py --ifn_samples ${dir}sams/${bn}.sam.bz2 --input_type sam --output_dir ${dir}consensus_markers >> ${dir}consensus_markers/log.txt
