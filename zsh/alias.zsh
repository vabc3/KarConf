alias -g G='|grep' 
alias -g H='|head'
alias -g W='|wc -l'
alias -g L='|less'
alias ls='ls -p --color=auto'
alias ll='ls -al'
alias grep='grep --colour=auto'
alias emerge='sudo emerge'
alias es='emerge --sync'
alias eac='emerge -avc'
alias ea='emerge -av'
alias e1='emerge -av1'
alias ew='emerge -avuND world'
alias etcu='sudo etc-update'
alias m='make'
alias mc='make clean'
alias mt='make test'
alias p='sudo pacman'
alias vi='vim'
alias s='xdg-open'
alias vima='sudo vi /etc/make.conf'
alias vius='sudo vi /etc/portage/package.use'
alias psg='ps aux G'
alias history='history -E 0'
alias ssh='ssh -o StrictHostKeyChecking=no'

#git command
alias gs='git status'
alias gd='git diff'
alias gcx='git clean -f -d -x'
alias gb='git branch -a'
alias gl='git log --graph --full-history --all --pretty=format:"%h%x09%d%x20%s"'
alias gr='git reflog'
alias ga='git add -A .'
alias gmt='git commit -m "tmp"'
alias gmm='git commit --amend --no-edit'
alias grh='git reset --hard'
alias gfp='git fetch -p --all'
alias gv='gitk --all'
alias gm='git checkout master'


alias b='cargo build'
