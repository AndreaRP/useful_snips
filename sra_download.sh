


# Check if the downloaded files from sra is correct (checks in /home/user/ncbi/*.sra files)
for f in *.fastq; do pf=${f%%.fastq}; echo $pf; vdb-validate $pf >> check.txt 2>&1; done