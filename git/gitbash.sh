# Global variables
re='^[0-9]+$'
base_branch='4.00-alpha'
# Will create a new branch with name ($1) from master
# it will also make sure master is up to date from origin
workstart() {
    if ! [[ $1 =~ $re ]]
    then
        val=$1
    else
        val="SLE-$1"
    fi
    git checkout $base_branch
    pull
    git checkout -b $val
}

# Will create remove the branch with name ($1) from local and origin
# before it removes, it will make sure master is up to date from origin
workdone() {
    if ! [[ $1 =~ $re ]]
    then
        val=$1
    else
        val="SLE-$1"
    fi
    git checkout $base_branch
    pull
    git branch -D $val
    # git push origin :$val
}

# Updates your current branch with origin/master even if you have uncommited changes
# D stands for dirty sio it will use stash to temporarly store your changes,
# sync with origin/master and then put your changes back
updateD() {
    git stash
    update
    git stash apply
}

# Updates your current branch with origin/master even, make you dont have uncommited changes
# sync with origin/master and then put your changes back
update() {
    if currentBranch=$(git symbolic-ref --short -q HEAD)
    then
        git checkout $base_branch
        pull
        git checkout $currentBranch
        git rebase $base_branch
    else
        echo not on any branch
    fi
}

# Rebase your current branch for last n($1) commits
# Its going to be interactive
# rebase() {
#     if [ -z $1 ]
#         then val=2
#     else
#         val=$1
#     fi
#     git rebase -i HEAD~$val
# }

# Force push current branch to origin
# It will not force push the master branch
fpush() {
    if [ -z $1 ]
        then echo "Need the name of the branch"
    else
        if [ "$1" == "master" ]
            then echo "Cant force push to master"
        else
            git push --force-with-lease origin $1
        fi
    fi
}

# Regular push current branch to origin
# It will not push the master branch
push() {
    if [ -z $1 ]
        then echo "Need the name of the branch"
    else
        git push base $1
    fi
}

# Log of commit messages in one line
log() {
    git log --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cd) %C(bold blue)<%an>%Creset' --abbrev-commit --date=short
}


# Status of git
status() {
    git status
}


# Pulls the changes for current branch from origin and merges them.
pull() {
    if currentBranch1=$(git symbolic-ref --short -q HEAD)
    then
        git pull base $currentBranch1 --rebase --prune
    else
        echo not on any branch
    fi
}

# Commit the files (on current branch) with the given message
# It will incluide all the files that have been modified and deleted.
# For new files you have to manually stage them using 'git add .'
commit() {
    local message=$@
    local currentBranch=$(git symbolic-ref --short -q HEAD)
    if [ -z "${message// }" ]
        then echo "Commit message missing"
    else
        git commit -am "$currentBranch # $message"
    fi
}

# Updates your fork from upstream master and pushes the updates to your origin fork
updateFork() {
    git checkout master
    git fetch base master
    git merge base/master
    push master
}

# exposed as alias on bash
alias ws=workstart
alias wd=workdone
alias rebase=rebase
alias fpush=fpush
alias push=push
alias update=update
alias updateD=updateD
alias log=log
alias pull=pull
alias s=status
alias c=commit
alias uf=updateFork
