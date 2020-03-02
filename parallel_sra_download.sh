#!/bin/bash
set -e

home_dir=$(echo -e "/data3/arubio/projects/Andrea_CircaN_rebuttal")
srr_file=$(echo -e "/data3/arubio/projects/Andrea_CircaN_rebuttal/docs/SRR_Acc_List.txt")

# parallel will automatically loop through the lines in the file, being {1} the reference to the file
# jobs 0 will run as many jobs in parallel as possible
cores=$(nproc --all) 
jobs_n=$(($cores / 2))
echo "Nº cores used: $jobs_n"


cmd="fastq-dump --outdir '${home_dir}/data/raw/ray_fastq/' {1}"
parallel --jobs ${jobs_n} --joblog ${home_dir}/data/raw/ray_fastq/jobs.log eval $cmd :::: ${srr_file}
#parallel --jobs ${jobs_n} --joblog ${home_dir}/data/raw/ray_fastq/jobs.log echo $cmd :::: ${srr_file}

# If I wanted to use 2 different files
# parallel --jobs ${jobs_n} --joblog ${home_dir}/jobs.log eval $cmd :::: ${file1} :::: ${file2}