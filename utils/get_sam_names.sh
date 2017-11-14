#!/bin/sh

dir=/users/k1639482/brc_scratch/STRAINS/

for ((i=1;i<=911;i+=1))
do
    sed -n "${i}p" sambz2_filenames.txt | cut -d . -f 1 >> ${dir}sambz2_names.txt
done

