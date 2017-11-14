#!/bin/sh

#$ -o ~/sge-out
#$ -e ~/sge-out

#$ -l h_vmem=19G
#$ -pe smp 20
#$ -R y

export MODULEPATH=/users/k1639482/modules:$MODULEPATH

module load miniconda/localconda_A strainphlan_src samtools bcftools muscle raxml

export PATH=/users/k1639482/repos/metaphlan2/strainphlan_src:$PATH

metaphlandir=/users/k1639482/repos/metaphlan2/
dir=/users/k1639482/brc_scratch/STRAINS/

python ${metaphlandir}strainphlan.py --mpa_pkl ${metaphlandir}db_v20/mpa_v20_m200.pkl --ifn_samples ${dir}consensus_markers/*.markers --output_dir ${dir}output --nprocs_main 20 --print_clades_only > ${dir}output/clades.txt
