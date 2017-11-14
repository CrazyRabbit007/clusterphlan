#!/bin/sh

dir=/users/k1639482/brc_scratch/STRAINS/

for ((i=1;i<=29;i+=1))
do
    sed -n "${i}p" saliva_filenames.txt | cut -f9- -d'/' |  cut -f1,2 -d'_' >> ${dir}saliva_sample_names.txt
done

