#!/bin/sh

dir=/users/k1639482/brc_scratch/STRAINS/
 
for ((i=1;i<=907;i+=1))
do
    sed -n "${i}p" ${dir}data/tmp.txt | cut -f1 -d'.' >> ${dir}data/consensus_marker_names.txt
done

