#color{{{
#autoload colors
#colors
 
#for color in RED GREEN YELLOW BLUE MAGENTA CYAN WHITE; do
#eval _$color='%{$terminfo[bold]$fg[${(L)color}]%}'
#eval $color='%{$fg[${(L)color}]%}'
#(( count = $count + 1 ))
#done
#FINISH="%{$terminfo[sgr0]%}"
#}}}


TOKENS_FOLLOWED_BY_COMMANDS=('|' '||' ';' '&' '&&' 'sudo' 'do' 'time' 
'strace')

recolor-cmd() {
    region_highlight=()
    colorize=true
    start_pos=0
    for arg in ${(z)BUFFER}; do
	((start_pos+=${#BUFFER[$start_pos+1,-1]}-${#${BUFFER[$start_pos+1,-1]###}}))
        ((end_pos=$start_pos+${#arg}))
        if $colorize; then
            colorize=false
            res=$(LC_ALL=C builtin type $arg 2>/dev/null)
            case $res in
                *'reserved word'*)   style="fg=red,bold";;
                *'alias for'*)       style="fg=cyan,bold";;
                *'shell builtin'*)   style="fg=yellow,bold";;
                *'shell function'*)  style='fg=green,bold';;
                *"$arg is"*)         [[ $arg = 'sudo' ]] && style="fg=red,bold" || style="fg=magenta,bold";;
                *)                   style='none';;
            esac
            region_highlight+=("$start_pos $end_pos $style")
        fi
        [[ ${${TOKENS_FOLLOWED_BY_COMMANDS[(r)${arg//|/\|}]}:+yes} = 'yes' ]] && colorize=true
        start_pos=$end_pos
    done
}

check-cmd-self-insert() { zle .self-insert && recolor-cmd }
check-cmd-backward-delete-char() { zle .backward-delete-char && 
recolor-cmd }

zle -N self-insert check-cmd-self-insert
zle -N backward-delete-char check-cmd-backward-delete-char




# number of lines kept in history
export HISTSIZE=1000000
# number of lines saved in the history after logout
export SAVEHIST=300000
# location of history
export HISTFILE=~/.zhistory
# append command to history file once executed
setopt inc_append_history



autoload -U compinit promptinit
compinit
promptinit; prompt gentoo

zstyle ':completion::complete:*' use-cache 1





exec 2>>(while read line; do 
print '\e[91m'${(q)line}'\e[0m' > /dev/tty; print -n $'\0'; done &)

#无需cd 进目录
setopt autocd 



alias ls='ls --color=auto'
alias grep='grep --colour=auto'
alias emerge='sudo emerge'
alias -g G='|grep' 

export GREP_COLOR='00;38;5;226'



bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward
bindkey "^[OH" beginning-of-line
bindkey "^[OF" end-of-line
bindkey "\e[3~" delete-char