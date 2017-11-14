#!/bin/sh

#$ -cwd

#$ -l h_vmem=8G
#$ -pe smp 20
#$ -R y

#$ -t 1-523
#$ -tc 10

export MODULEPATH=/users/k1639482/modules:$MODULEPATH

module load miniconda/localconda_A
module load bowtie2
module load strainphlan

metaphlandir=/users/k1639482/repos/metaphlan2/
dir=/users/k1639482/brc_scratch/STRAINS/
raw_dir=/mnt/lustre/groups/chmi2/ORAL_MICROBIOME/CHINESE/RAW_MERGED/

bn=$(sed -n "${SGE_TASK_ID}p" ${dir}data/chinese_sample_names.txt)
f=$(ls ${raw_dir}Z_${bn}*_1.* | sed -n '1p')
g=$(ls ${raw_dir}Z_${bn}*_2.* | sed -n '1p')

echo "Extracting file $f "

if [ ${f: -8} = "fastq.gz" ]; then
	zcat $f > ${dir}Z_${bn}_1.fastq
elif [ ${f: -8} = "q.tar.gz" ]; then
	tar -xvzf $f
	mv ${dir}export/mgps/home/dgomez/PROCESS/CHINESE/RAW_MERGED/${bn}_trimmo_trimmed_and_filtered_1.fastq ${dir}Z_${bn}_1.fastq
else
	echo "Check file extension!"
fi

echo "Extractong file $g "
if [ ${g: -8} = "fastq.gz" ]; then
	zcat $g > ${dir}Z_${bn}_2.fastq
elif [ ${g: -8} = "q.tar.gz" ]; then
	tar -xvzf $g
	mv ${dir}export/mgps/home/dgomez/PROCESS/CHINESE/RAW_MERGED/${bn}_trimmo_trimmed_and_filtered_2.fastq	${dir}Z_${bn}_2.fastq
else
	echo "Check file extension!"
fi

echo "Running metaphlan"
${metaphlandir}metaphlan2.py ${dir}Z_${bn}_1.fastq,${dir}Z_${bn}_2.fastq --bowtie2db ${metaphlandir}db_v20/mpa_v20_m200 --mpa_pkl ${metaphlandir}db_v20/mpa_v20_m200.pkl --input_type multifastq --nproc 20 -s ${dir}sams/Z_${bn}.sam.bz2 --bowtie2out ${dir}sams/Z_${bn}.bowtie_out.bz2 -o ${dir}sams/Z_${bn}.profile
