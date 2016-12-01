TH=$1

echo "Target Host:$TH"
scp vim/.vimrc $TH:.vimrc
cp zsh/main.zsh /tmp/.zshrc
cat zsh/alias.zsh >> /tmp/.zshrc
cat ~/git/oh-my-zsh/lib/key-bindings.zsh >> /tmp/.zshrc
scp /tmp/.zshrc $TH:.zshrc


