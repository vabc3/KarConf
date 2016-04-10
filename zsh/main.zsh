#在命令前插入 sudo 定义快捷键为： [Esc] [Esc]
sudo-command-line() {
	[[ -z $BUFFER ]] && zle up-history
	[[ $BUFFER != sudo\ * ]] && BUFFER="sudo $BUFFER"
	zle end-of-line
}
zle -N sudo-command-line

bindkey "\e\e" sudo-command-line


#直接按tab显示目录
user-complete(){
	if [[ -n $BUFFER ]] ; then   
		zle expand-or-complete
	else
		BUFFER="cd "
		zle end-of-line
		zle expand-or-complete
	fi
}
zle -N user-complete
bindkey "\t" user-complete

#路径别名
hash -d kc="/home/rquiss/git/KarConf"
hash -d me="/run/media/rquiss"

#启用等号
unsetopt equals
#退出进程后不取消掉
setopt NO_HUP

#历史记录
# number of lines kept in history
export HISTSIZE=1000000
# number of lines saved in the history after logout
export SAVEHIST=300000
# location of history
export HISTFILE=~/.zhistory
# append command to history file once executed
setopt inc_append_history
setopt EXTENDED_HISTORY

#提示符
autoload -U promptinit
promptinit; prompt gentoo

#错误提示颜色
#exec 2>>(while read line; do 
#print '\e[91m'${(q)line}'\e[0m' > /dev/tty; print -n $'\0'; done &)

#无需cd 进目录
setopt autocd 

#Grep命令颜色
export GREP_COLOR='00;38;5;226'

#bindkey "^[OH" beginning-of-line
#bindkey "^[OF" end-of-line
#bindkey "\e[3~" delete-char
eval "$(sed -n '/\#/d; s/^/bindkey /; s/: / /p;' /etc/inputrc)"

#modify up down
bindkey '^[[A' history-beginning-search-backward
bindkey '^[[B' history-beginning-search-forward

#hbsb() {
#	zle up-history
#}
#zle -N hbsb
#bindkey ']' hbsb
#


#自动补全功能
#setopt AUTO_LIST
#setopt AUTO_MENU
#开启此选项，补全时会直接选中菜单项
#setopt MENU_COMPLETE

autoload -U compinit
compinit

#自动补全缓存
zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path .zcache
zstyle ':completion:*:cd:*' ignore-parents parent pwd

#自动补全选项
zstyle ':completion:*:match:*' original only
zstyle ':completion::prefix-1:*' completer _complete
zstyle ':completion:predict:*' completer _complete
zstyle ':completion:incremental:*' completer _complete _correct
zstyle ':completion:*' completer _complete _prefix _correct _prefix _match _approximate

#路径补全
zstyle ':completion:*' expand 'yes'
zstyle ':completion:*' squeeze-shlashes 'yes'
zstyle ':completion::complete:*' '\\'

zstyle ':completion:*' menu select
zstyle ':completion:*:*:default' force-list always

#彩色补全菜单 
##eval $(dircolors -b) 
##export ZLSCOLORS="${LS_COLORS}"
zmodload zsh/complist
##zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
##zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) 
#([0-9]#)*=0=01;31'

#错误校正      
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric

#kill 命令补全      
compdef pkill=kill
compdef pkill=killall
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:*:*:*:processes' force-list always
zstyle ':completion:*:processes' command 'ps -au$USER'

#补全类型提示分组 
zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*' group-name ''
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'
##zstyle ':completion:*:descriptions' format $'\e[01;33m -- %d --\e[0m'
##zstyle ':completion:*:messages' format $'\e[01;35m -- %d --\e[0m'
##zstyle ':completion:*:warnings' format $'\e[01;31m -- No Matches Found --\e[0m'

zstyle ':completion:*:descriptions' format $'%{\e[01;33m%} -- %d --%{\e[0m%}'
zstyle ':completion:*:messages' format $'%{\e[01;35m%}-- %d --%{\e[0m%}'
#zstyle ':completion:*:warnings' format $'%{\e[01;31m%}-- No Matches Found --%{\e[0m%}'

if [ $UID != 0 ]; then
	export PS1="%F{green}%B%n%F{yellow}@%F{green}%M%k %B%F{blue}%1~ %# %b%f%k";
fi
#for nmon
unset COLORFGBG   

#disable ^S
#stty stop ''
stty -ixon

PATH="/usr/sbin:/sbin:${PATH}"
PATH=~/.nodejs/bin:$PATH

if [ $TERM = 'rxvt-unicode-256color' ]; then
	ZSH_THEME="kar"
	TERM=rxvt-unicode
fi
