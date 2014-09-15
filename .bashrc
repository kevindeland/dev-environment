alias ll='ls -l'                              # long list
alias la='ls -A'                              # all but . and ..
alias l='ls -CF'                              #

alias sls='screen -ls'
function srs(){
    screen -r $1
}
function sns(){
    screen -S $1
}
alias sws='screen -wipe'

