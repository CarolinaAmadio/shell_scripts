#!/bin/bash

module load nco

input_dir="/g100_work/OGS_devC/Benchmark/SETUP/PREPROC/IC/"
output_dir="/g100_work/OGS_devC/camadio/Neccton_hindcast1999_2022/wrkdir/IC/"
meshmask="/g100_work/OGS_devC/camadio/Neccton_hindcast1999_2022/wrkdir/MODEL/meshmask.nc"

for file in $input_dir/RST.20190101-00:00:00.*.nc; do
    # change date  in filename
    VAR=$(basename $file | sed 's/RST.20190101-00:00:00.\(.*\)\.nc/\1/')
    output_file="$output_dir/RST.20190101-00:00:00.$VAR.nc"
    # nearest interpolation
    ncremap -m nearest_stod -i $file -o $output_file -d $meshmask

    if [ $? -eq 0 ]; then
        echo "Successfully processed: $file"
    else
        echo "Error processing: $file"
    fi
done

# if you need to rename
#for i in *2019*; do     mv "$i" "${i/2019/1999}"; done
