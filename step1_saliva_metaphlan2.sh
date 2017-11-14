#!/bin/sh

#$ -e ~/sge-out
#$ -o ~/sge-out

#$ -l h_vmem=20G
#$ -t 1-29
#$ -tc 10

export MODULEPATH=/users/k1639482/modules:$MODULEPATH

module load miniconda/localconda_A
module load bowtie2
module load strainphlan

metaphlandir=/users/k1639482/repos/metaphlan2/
dir=/users/k1639482/brc_scratch/STRAINS/
chmi_dir=/mnt/lustre/groups/chmi/ORAL_MICROBIOME/SALIVA/RAW_MERGED/

bn=$(sed -n "${SGE_TASK_ID}p" ${dir}saliva_sample_names.txt)

echo "Running metaphlan"
${metaphlandir}metaphlan2.py ${chmi_dir}${bn}_trimmo_trimmed_and_filtered_275.fastq --bowtie2db ${metaphlandir}db_v20/mpa_v20_m200 --mpa_pkl ${metaphlandir}db_v20/mpa_v20_m200.pkl --input_type fastq --nproc 20 -s ${dir}sams/${bn}.sam.bz2 --bowtie2out ${dir}sams/${bn}.bowtie_out.bz2 -o ${dir}sams/${bn}.profile
