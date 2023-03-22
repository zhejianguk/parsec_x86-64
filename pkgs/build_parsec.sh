#!/bin/bash

gc_kernel=none

rm -f *.o
rm -f *.riscv

# Input flags
while getopts k: flag
do
	case "${flag}" in
		k) gc_kernel=${OPTARG};;
	esac
done

input_type=simmedium

export PATH_GC_KERNELS="/home/centos/gc_kernel/"
export PATH_PKGS=$PWD

cd $PATH_PKGS

BENCHMARKS=(blackscholes bodytrack dedup facesim ferret fluidanimate freqmine streamcluster swaptions x264)

cmd="parsecmgmt -a clean -p all"
eval ${cmd}
cmd="parsecmgmt -a fulluninstall -p all"
eval ${cmd}


for benchmark in ${BENCHMARKS[@]}; do

    cmd="parsecmgmt -a build -p ${benchmark}"
    eval ${cmd}

    cmd="parsecmgmt -a run -p ${benchmark} -i ${input_type}"
    eval ${cmd}

done

echo ""
echo "All Done!"
