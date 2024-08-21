#!/bin/bash

module load nco

input_dir="/g100_work/OGS_devC/Benchmark/SETUP/PREPROC/IC/"
output_dir="/g100_work/OGS_devC/camadio/Neccton_hindcast1999_2022/wrkdir/IC/"
meshmask="/g100_work/OGS_devC/camadio/Neccton_hindcast1999_2022/wrkdir/MODEL/meshmask.nc"



# if you need to rename
#for i in *2019*; do     mv "$i" "${i/2019/1999}"; done
