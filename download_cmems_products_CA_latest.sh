#!/bin/bash

#
# The script read year(s) from standard input
# The destination directory can be optionally specified on command line as first parameter
#
# Usage examples:
#
# To download year 2020 data
# echo 2020 | ./download_cmems_products.sh
#
# To download data from year 2017 to year 2020
# seq 2017 2020 | ./download_cmems_products.sh
#
# To download data into directory "/download_dir"
# echo 2020 | ./download_cmems_products.sh download_dir/
#

####### CLS #################
declare -r SITE="nrt.cmems-du.eu";
declare -r USER="camadio";
declare -r PASS="Bsqx3066!!";
###################################

declare DOWNLOAD_DIR="/g100_scratch/userexternal/camadio0/GL_CMEMS/CMEMS_013_035_GL_DATA/LATEST/";
declare FTP_BASE_PATH="/Core/INSITU_MED_PHYBGCWAV_DISCRETE_MYNRT_013_035/cmems_obs-ins_med_phybgcwav_mynrt_na_irr/latest/";
declare FTP_indextxt_PATH="/Core/INSITU_MED_PHYBGCWAV_DISCRETE_MYNRT_013_035/cmems_obs-ins_med_phybgcwav_mynrt_na_irr/";

if [ $# -ge 1 ]; then
	DOWNLOAD_DIR="$1";
fi

echo ${DOWNLOAD_DIR}

if [ ! -d "${DOWNLOAD_DIR}" ]; then
	mkdir "${DOWNLOAD_DIR}" || { echo "Unable to create destination directory" >&2; exit 1; };
fi

while read YEAR
do

	seq 11 12 |\
	while read MONTH
	do
		printf -v MONTH "%02d" ${MONTH};
		seq 1 31 |\
		while read DAY
		do
			printf -v DAY "%02d" ${DAY};

			FTP_URL="ftp://${SITE}${FTP_BASE_PATH}/${YEAR}${MONTH}${DAY}/";
       		        echo $FTP_URL
			# list files
			curl \
				--silent \
				--user ${USER}:${PASS} \
				--list-only \
				${FTP_URL} |\
			while read FILENAME
			do
				# download file
				curl \
					--silent \
					--user ${USER}:${PASS} \
					--output "${DOWNLOAD_DIR}/${FILENAME}" \
					"${FTP_URL}${FILENAME}" \
				;
			done
		done
	done
done

FTP_URL_="ftp://${SITE}${FTP_indextxt_PATH}/"
FILENAME_=index_latest.txt
curl \
  --silent \
  --user ${USER}:${PASS} \
  --output "${DOWNLOAD_DIR}/${FILENAME_}" \
  "${FTP_URL_}${FILENAME_}" \
  ;

exit 0;

