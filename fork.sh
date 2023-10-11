clear

FAILED=false
nameC=false
skipName=false

echo "Welcome to github overwrite forker"
echo "(will on work on YOUR repositorys *nice try*)"
read -p "[Link for repo to fork]#> " testie

if [[ $testie == "deleteAll" ]]; then
    echo "THIS WILL DELETE ALL FILES ON YOUR REPO"
    testie="https://github.com/WaveDemure/mt.git"
    skipName=true 
    Nane="mt"
    nameC=true
fi

if [[ $skipName != true ]]; then
    read -p "[Name of the repo your forking]#> " Nane 
    if echo $testie | grep $Nane; then
        echo "FOUND NAME"
        nameC=true
    else
        echo "ABORTING NAME NOT FOUND"
    fi 
fi

if [[ $nameC == true ]]; then
    git clone --bare -q $testie
    cd $Nane.git
    read -p "[Link to your repository]> " newmirror
    git push --mirror $newmirror.git
    cd -
    echo "Done!"
    rm -rf $Nane.git
fi
