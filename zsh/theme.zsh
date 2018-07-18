if ! [[ $TERM =~ 'linux' ]]; then
  ZSH_THEME="powerlevel9k/powerlevel9k"
fi
#POWERLEVEL9K_MODE=awesome-fontconfig
#POWERLEVEL9K_CONTEXT_TEMPLATE="%m"
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(virtualenv context dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status)
POWERLEVEL9K_SHORTEN_DIR_LENGTH=2


