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
