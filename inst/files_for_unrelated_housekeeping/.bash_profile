
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/xzfang/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/xzfang/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/xzfang/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/xzfang/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


# because 
# When invoking a login shell bash will looks for its config files in this order:

# [0] ~/.bash_profile
# [1] ~/.bash_login
# [2] ~/.profile
# for ubuntu 

if [ -f "$HOME/.bashrc" ]; then
    . "$HOME/.bashrc"
fi

if [ -f "$HOME/.profile" ]; then
    . "$HOME/.profile"
fi

function inter(){
srun --partition=short --mem=6G --time="$@":00:00 --pty bash 
}

alias my_q='squeue -u xfang4'

module add singularity 

function push(){
git pull 
text=`git remote -v` &&
num_lines=`git remote -v | wc -l` &&
if [ "$num_lines" -ge 4 ]; then
    if [[ $text == *pav* ]]; then
	git pull pav main
	git pull pav master
	git push pav
    fi
    if [[ $text == *heroku* ]]; then git push heroku
    fi
    if [[ $text == *github* ]]; then # this is for overleaf project, origin would be overleaf, github would be github, this line would be called by when origin is github due to the url, and there will be "fatal: 'github' does not appear to be a git repository", well it's harmless, i am letting it be
	git pull github main
	git pull github master
	git push github
    fi
fi 
git add -A &&
if [ -z "$1" ];then
  git commit -m"insignificant commit"
else
  git commit -m"$@"
fi 
git push
if [ "$num_lines" -ge 4 ]; then
    if [[ $text == *pav* ]]; then
	git pull pav main
	git pull pav master
	git push pav
    fi
    if [[ $text == *heroku* ]]; then git push heroku
    fi
    if [[ $text == *github* ]]; then # this is for overleaf project, origin would be overleaf, github would be github, this line would be called by when origin is github due to the url, and there will be "fatal: 'github' does not appear to be a git repository", well it's harmless, i am letting it be
	git pull github main
	git pull github master
	git push github
    fi
fi 
}


function up(){
cd ~/Github
for dir in $(ls);
do
  echo ""
  echo ""
  echo $dir
  cd ~/Github/$dir
  PUSH "up"
done
}

# https://stackoverflow.com/questions/12641469/list-submodules-in-a-git-repository
function PUSH(){
  text=`git config --file .gitmodules --get-regexp path | awk '{ print $2 }'`
  for line in $text ;
  do
    cd $line
    push "$@"
    cd ..
  done
  push "$@"
}


function clean(){
rm ~/Desktop/Screen\ Shot\ *
rm ~/Desktop/*.dmg
rm ~/Desktop/*.gz
rm ~/Downloads/*
rm ~/Desktop/*.pkg
}

function backup_zotero(){
cd ~
rm Zotero/*sqlite*bak
cp -r Zotero /Volumes/TedLabPascal/Zotero
}

function pub(){
cd ~/Github/mybd
# blogdown only knit content listed on menu to public, maybe they don't clean public first so that people have th choice to have things not list on menu
# those hidden pages are still accessible by search engine tho
rm -rf public/* &&
cd static/cv &&
R --slave -e "rmarkdown::render('index.Rmd')" &&
cd ../../ &&
#tried got rscript not found
#Rscript.exe -e "blogdown::build_site()" &&
R --slave -e "blogdown::build_site()" &&
cd ../xf15.github.io &&
rm -rf * &&
cp -r ../mybd/public/* . &&
push "pub"
}

function monthly(){
clean
backup_zotero
}

cd ~/Github

# to run a script called test.m, then do matlab -batch "test"
alias matlab="/Applications/MATLAB_R2020b.app/bin/matlab -nojvm -nodesktop"
