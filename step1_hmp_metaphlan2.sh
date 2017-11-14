#!/bin/sh

#$ -cwd

#$ -l h_vmem=20G
#$ -pe smp 10
#$ -R y

#$ -t 1-361
#$ -tc 10

export MODULEPATH=/users/k1639482/modules:$MODULEPATH

module load miniconda/localconda_A
module load bowtie2
module load strainphlan

metaphlandir=/users/k1639482/repos/metaphlan2/
dir=/users/k1639482/brc_scratch/STRAINS/

bn=$(sed -n "${SGE_TASK_ID}p" ${dir}data/hmp_sample_names.txt)

echo "Extracting .gz for sample $bn "
zcat /mnt/lustre/groups/chmi2/ORAL_MICROBIOME/HMP/RAW_MERGED/${bn}_trimmo_trimmed_and_filtered_1.fastq.gz > ${dir}${bn}_1.fastq
zcat /mnt/lustre/groups/chmi2/ORAL_MICROBIOME/HMP/RAW_MERGED/${bn}_trimmo_trimmed_and_filtered_2.fastq.gz > ${dir}${bn}_2.fastq

echo "Running metaphlan"
${metaphlandir}metaphlan2.py ${dir}${bn}_1.fastq,${dir}${bn}_2.fastq --bowtie2db ${metaphlandir}db_v20/mpa_v20_m200 --mpa_pkl ${metaphlandir}db_v20/mpa_v20_m200.pkl --input_type multifastq --nproc 20 -s ${dir}sams/${bn}.sam.bz2 --bowtie2out ${dir}sams/${bn}.bowtie_out.bz2 -o ${dir}sams/${bn}.profile

echo "Removing fastq"
rm ${dir}${bn}_1.fastq
rm ${dir}${bn}_2.fastq
