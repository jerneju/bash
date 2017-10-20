# aliases
# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
# -p, --file-type   Append indicator (one of /=@|) to entries
# -a, --all    List all entries including those starting with a dot .
# -l    Use a long listing format
# -h, --human-readable Print sizes in human readable format (e.g., 1K 234M 2G)
# --size    Print size of each file, in blocks
# -t    sort by modification time
# -u    sort by last access time; with -l: show atime
alias dir='ls -palh --size'
alias ..='cd ..'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias mkdir='mkdir -p'
alias h='history'
alias j='jobs -l'
alias o='orange-canvas -l 4'
alias or='orange-canvas --clear-widget-settings -l 4'
alias oc='orange-canvas --clear-widget-settings'
alias t='python -m unittest'
alias gc='git checkout'
alias gl='git log --name-only'
alias jn='jupyter notebook'

#My functions
# https://stackoverflow.com/questions/2421011/output-of-git-branch-in-tree-like-fashion
glg() {
    git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset%n' --abbrev-commit --date=relative --branches
}
gr() {
    git rebase -i HEAD~$1
}
# Compare two files. Can be used outside of a repository.
gdf() {
    git diff --no-index $1 $2
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
# ffmpeg
mpeg-extract() {
    ffmpeg -ss 00:$2 -i $1 -to 00:$3 -acodec copy -vcodec copy $4
}
mpeg-concat() {
    ffmpeg -i "concat:$1|$2" -acodec copy -vcodec copy $3
}
