TH=$1

echo "Target Host:$TH"
scp vim/.vimrc $TH:.vimrc
cp zsh/main.zsh /tmp/.zshrc
cat zsh/alias.zsh >> /tmp/.zshrc
scp /tmp/.zshrc $TH:.zshrc


