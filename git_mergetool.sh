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
