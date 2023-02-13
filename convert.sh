perl -p -ne "s/alias (.*)='(.*)'/function \$1() {\$2}/" git.zsh
