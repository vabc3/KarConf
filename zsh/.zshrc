#定义Xsession
#if [ `hostname` = 'Karata-Laptop' ]; then
#	export XSESSION="compiz-session" 
#fi

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

TOKENS_FOLLOWED_BY_COMMANDS=('|' '||' ';' '&' '&&' 'sudo' 'do' 'time' 'strace')

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
check-cmd-backward-delete-char() { zle .backward-delete-char && recolor-cmd }

zle -N self-insert check-cmd-self-insert
zle -N backward-delete-char check-cmd-backward-delete-char



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

alias ls='ls -p --color=auto'
alias ll='ls -al'
alias grep='grep --colour=auto'
alias emerge='sudo emerge'
alias -g es='emerge --sync'
alias -g eac='emerge -avc'
alias -g ea='emerge -av'
alias -g e1='emerge -av1'
alias -g ew='emerge -avuND world'
alias -g etcu='sudo etc-update'

if [ -e '/etc/gentoo-release' ]; then
	alias -g srv='sudo service';
else 
	alias -g srv='sudo rc.d';
fi

alias -g G='|grep' 
alias -g H='|head'
alias -g W='|wc -l'
alias -g L='|less'
alias -g m='make'
alias -g mc='make clean'
alias -g mt='make test'
alias -g pa='fakeroot pacman'
alias -g vi='vim'
alias -g s='xdg-open'
alias -g vima='sudo vi /etc/make.conf'
alias -g vius='sudo vi /etc/portage/package.use'
alias -g psg='ps aux G'

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

#export TERM=rxvt-unicode
export TERM=rxvt
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
