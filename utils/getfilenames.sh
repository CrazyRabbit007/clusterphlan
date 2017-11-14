#!/bin/sh

#$ -cwd

#$ -l h_vmem=2G
#$ -pe smp 20
#$ -q HighMemLongterm.q,LowMemLongterm.q

metaphlandir=/users/k1639482/repos/metaphlan2/
mkdir -p ${dir}sams

for f in $(ls /mnt/lustre/groups/chmi/ORAL_MICROBIOME/HMP/RAW_MERGED/*_1.fastq.gz)
do
    echo "Extracting ${f}.."
    bn=$(/bin/basename ${f} | cut -d _ -f 1)
done
