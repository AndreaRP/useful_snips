# https://www.biostars.org/p/78043/

#zcat: print gzipped file (if the file is not zipped, just use cat)
zcat file.fq.gz | paste - - - - | cut -f2 | | sed 's/[[:blank:]]//' | wc -c

# print four consecutive lines in one row (tab delimited)
#paste - - - -: 

# print only the second column (after paste this is the second line of the fastq-format, meaning the sequence)
#cut -f2: 

#wc -c: count the characters