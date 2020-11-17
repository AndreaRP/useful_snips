# Initialize repo in folder
git init
# Add .gitignore file
git add .gitignore 
git commit -m "Add ignore file"
# Add files you want
git add .
# find . \( -name "*.Rmd" -or -name "*.R" \) -exec git add {} \;
# commit changes
git commit -m "added files to the repo"
# Map remote repo to local repo
git remote add origin https://github.com/AndreaRP/repo_name
# Pull the master branch from remote (with a readme)
# Push your files into remote
git push origin master


## If I accidentally add files I dont want in my repo I just delete them from 
## the "following" file by using rm --cached. This removes the files from the repo
## But not from the local disk!
git rm -r --cached submission/*.zip

## If the worst happens and you accidentally delete files you wanted to keep
## by using a hard reset, you can recover them by first localizing the version
## in which you still had them
git reflog # Gives you the commits you have made
## then you can use a hard reset on the version that stilla had the files
git reset --hard 32f9337

# After set up you just commit and push

# Modify URL of git
git remote set-url origin_name git://new.url.here


# Add or remove files to git repo
git add file1.txt
git rm file1.txt

# Setup user and pass:
git config --global credential.helper store
git pull