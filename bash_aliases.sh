# aliases
# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias dir='ls -palh'
alias ..='cd ..'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias mkdir='mkdir -p'
alias h='history'
alias j='jobs -l'
alias o='orange-canvas'
alias or='orange-canvas --clear-widget-settings'
alias oc='orange-canvas --clear-widget-settings'
alias t='python -m unittest'
alias gl='git log --name-only'

#My functions
gr() {
    git rebase -i HEAD~$1
}
gd() {
    git diff HEAD~$1 $2
}
gb() {
    git for-each-ref --sort=committerdate refs/heads/ --format='%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - %(color:red)%(objectname:short)%(color:reset) - %(contents:subject) - %(authorname) (%(color:green)%(committerdate:relative)%(color:reset))'
}
git-split() {
    set -e

    LF=$'\n'
    SHA=$(git rev-parse --short HEAD)
    MSG=$(git show -s --format=%B HEAD)
    set -f; IFS=$'\n'
    FILES=($(git diff-tree --no-commit-id --name-only -r HEAD))
    set +f; unset IFS

    git reset HEAD^

    for f in "${FILES[@]}"; do
      git add "$f"
      git commit -m "$SHA $f$LF$LF$MSG"
    done
}
git-copy() {
    git mv $1 $2
    git commit -n
    SAVED=`git rev-parse HEAD`
    git reset --hard HEAD^
    git mv $1 foo-magic
    git commit -n
    git merge $SAVED # This will generate conflicts
    git commit -a -n # Trivially resolved like this
    git mv foo-magic $1
    git commit -n
}
cov() {
    if [ -f tests/test_$1 ]; then
        coverage run -m unittest tests/test_$1
        coverage html --include $1
    elif [ -f test_$1 ]; then
        coverage run -m unittest test_$1
        coverage html --include ../$2/$1
    else
        echo Test file not found
    fi
}
