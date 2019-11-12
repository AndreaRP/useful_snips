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


# After set up you just commit and push

# Modify URL of git
git remote set-url origin_name git://new.url.here


# Add or remove files to git repo
git add file1.txt
git rm file1.txt

# Setup user and pass:
git config --global credential.helper store
git pull