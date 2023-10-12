if [[ $REPL_ID != "" ]]; then
  echo "Replit detected. Running script..."
else
  echo "Replit not detected. Aborting"
  exit 1
fi
clear

# Traps for exits
traps() {
  echo
  rm -rf !(*.sh)
  gh auth logout
  echo "Verify with gh auth status"
}
trap traps 0 # This logs out of GH even if terminated
quiteMode=false # Factory Variable ignore (testing) all this is if it makes the git clone output not quite

echo "Hello welcome to the replit version of git cloner"
echo "I recommend looking at the source code"
read -p "Enter to continue" factor

case $factor in
  factory | q) # Factory stuff ignore (testing)
    echo "Running in factory mode (no -q)"
    quiteMode=true
  ;;
esac

gh auth logout # Ensure there is no login info in the repl
gh auth login # Login with GH
gh auth status # Chech the status of the logined in user
sleep 1
clear

if ! gh auth status >/dev/null 2>&1; then # Checks if there is a logined user
    echo "You need to login: gh auth login"
    exit 1
fi

read -p "Paste the link to the repo you want to fork []> " fork # Obtain the fork link
echo
smallLink=${fork//'https://github.com/'/} # Fork smallLink (user/repo)
echo $smallLink
name=$(cut -d "/" -f2 <<< "$smallLink")  # Get the name of repo
echo $name
echo
echo "Cloning $smallLink..."

if [[ $quiteMode == true ]]; then
  git clone --bare $fork.git
else
  git clone --bare -q $fork.git
fi

cd $name.git # Change dir to the git repo

read -p "[Link to your repository]> " newmirror  
git push --mirror $newmirror.git
cd - # Change dir back to the pwd (home)

echo "Done!"
rm -rf $name.git

# The end of the script

# gh auth logout (this is no longer need with the traps)


