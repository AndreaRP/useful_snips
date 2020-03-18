# Mount shiny folder
sshfs -o uid=$(id -u) -o gid=$(id -g) arubio@10.149.80.235:/home/arubio/ShinyApps /home/arubio/shiny_server
(Pass: same as cluster)


# Send job to cluster without script
echo "command" | qsub -P AG -A arubio -N "job_name"

# Halt job in the cluster and resend
qalter -h u BL* (name oj the job)
qmod -rj BL*
qalter -h U -u arubio (esto remanda los trabajos que estaban en hold)

# Edit pdf
pdftk A=inA.pdf B=inB.pdf cat A1-12 B3 A14-end output out1.pdf

pdftk A=/home/arubio/Documents/Doctorado/Cosas_informe_de_tutela/2017_plan_investigacion_reviewed.pdf B=/home/arubio/Documents/Doctorado/plan_investigación_firmado.pdf C=/home/arubio/Documents/Doctorado/anexo_I_firmado.pdf cat A1-5 B1 A7-13 C1 output /home/arubio/Documents/Doctorado/plan_investigacion_final.pdf

pdftk A=/home/arubio/Documents/Doctorado/plan_investigacion_final.pdf B=/home/arubio/Documents/Doctorado/anexo_I_firmado_movido.pdf cat A1-13 B1 output /home/arubio/Documents/Doctorado/plan_investigacion_final_1.pdf

# Copy a file maintaining directory structure (from /run/user/10601/gvfs/smb-share:server=tierra.cnic.es,share=sc/LAB_AH/LAB/Andrea/Ivan_Neutrophils_circadian_BM/PROCESSED)
find . -name '*.genes.results' -exec cp --parents \{} /data3/arubio/projects/Ivan_Neutrophils_circadian_BM/PROCESSED/ \;
find . \( -name "*.Rmd" -or -name "*.R" \) -exec cp --parents \{\} ./backup/ \;

# Copy without folder structure
find . -name '*.fastq.gz' -exec cp {} /data3/arubio/projects/Tissue_Neutrophils_scRNAseq/geo/raw/ \;

# Change file names in batch
ls | while read file; do newfile=`echo $file | awk -F . '{print $1 "_" $9 ".fastq.gz"}'`; echo $newfile;  mv $file $newfile; done;

# Unzip only specific files
find . -name "*.zip" -type f -exec unzip -jd "raw/" "{}" "*.fastq.gz" "*.gif" \;


########### GIT ############
# Initialize repo in folder
git init
# Add files you want
find . \( -name "*.Rmd" -or -name "*.R" \) -exec git add {} \;
# commit changes
git commit -m "added files to the repo"
# Map remote repo to local repo
git remote add projects_cnic https://github.com/AndreaRP/projects_cnic
# Pull the master branch from remote (with a readme)
git pull projects_cnic master
# Push your files into remote
git push -u projects_cnic master


# After set up you just commit and push

# Modify URL of git
git remote set-url origin_name git://new.url.here


# Add or remove files to git repo
git add file1.txt
git rm file1.txt

In case of commit conflict:

Step 0: Install bcompare:

wget https://www.scootersoftware.com/bcompare-4.2.4.22795_amd64.deb
sudo apt-get update
sudo apt-get install gdebi-core
sudo gdebi bcompare-4.2.4.22795_amd64.deb

Step 1: Run following commands in your terminal

git mergetool

Step 2: You will see a vimdiff display in following format

  +----------------------+
  |       |      |       |
  |LOCAL  |BASE  |REMOTE |
  |       |      |       |
  +----------------------+
  |      MERGED          |
  |                      |
  +----------------------+

These 4 views are

    LOCAL – this is file from the current branch

    BASE – common ancestor, how file looked before both changes

    REMOTE – file you are merging into your branch

    MERGED – merge result, this is what gets saved in the repo

You can navigate among these views using ctrl+w. You can directly reach MERGED view using ctrl+w followed by j.

More info about vimdiff navigation here and here

Step 3. You could edit the MERGED view the following way

If you want to get changes from REMOTE

:diffg RE  

If you want to get changes from BASE

:diffg BA  

If you want to get changes from LOCAL

:diffg LO 

Step 4. Save, Exit, Commit and Clean up

:wqa save and exit from vi

git commit -m "message"

git clean -n (this will show the files that will be deleted)
git clean -f (actually delete the files)

