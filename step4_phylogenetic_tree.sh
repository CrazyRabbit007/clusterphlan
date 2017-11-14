#!/bin/sh

#$ -o ~/sge-out
#$ -e ~/sge-out

#$ -l h_vmem=10G
#$ -pe smp 10

#$ -t 1-509
#$ -tc 10

export MODULEPATH=/users/k1639482/modules:$MODULEPATH

module load miniconda/localconda_A strainphlan_src samtools bcftools muscle raxml

export PATH=/users/k1639482/repos/metaphlan2/strainphlan_src:$PATH

metaphlandir=/users/k1639482/repos/metaphlan2/
dir=/users/k1639482/brc_scratch/STRAINS/
CLADE=$(sed -n "${SGE_TASK_ID}p" ${dir}output/clades2.txt)

python ${metaphlandir}strainphlan.py --mpa_pkl ${metaphlandir}db_v20/mpa_v20_m200.pkl --ifn_samples ${dir}consensus_markers/*.markers --ifn_markers ${dir}db_markers/all_markers.fasta --output_dir ${dir}output --nprocs_main 10 --clades ${CLADE} &> ${dir}output/log_${SGE_TASK_ID}_${CLADE}.txt
