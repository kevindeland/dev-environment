alias ls='ls --color'
alias ll='ls -l --color'                              # long list
alias la='ls -A --color'                              # all but . and ..
alias l='ls -CF --color'                              #

alias sls='screen -ls'
function srs(){
    screen -r $1
}
function sns(){
    screen -S $1
}
alias sws='screen -wipe'

function gitev() {
    git add . && git commit -m '$1' && git push -u origin master
}

function grepxnode() {
    grep -R --exclude-dir=node_modules $1 $2
}


alias ayy='echo lmao'
export PATH="$HOME/.cfenv/bin:$PATH"
eval "$(cfenv init -)"
