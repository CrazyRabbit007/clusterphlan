#!/bin/sh

dir=/users/k1639482/brc_scratch/STRAINS/

for ((i=1;i<=911;i+=1))
do
	string=$(sed -n "${i}p" ${dir}data/sambz2_names.txt) 
	if grep -q ${string} ${dir}data/succ_strainphlan.txt; then
		echo "Found"
	else	
		echo "Not Found"
		echo $(sed -n "${i}p" ${dir}data/sambz2_names.txt) >> ${dir}data/unsucc_strainphlan.txt
	fi
done

