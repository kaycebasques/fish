#!/usr/bin/fish

ssh-keygen -t ed25519 -C "kaycebasques@gmail.com"
eval (ssh-agent -c)
ssh-add $HOME/.ssh/id_ed25519
echo "TODO: Add the following key to https://github.com/settings/ssh/new"
cat $HOME/.ssh/id_ed25519.pub

cd $HOME/cli
git remote set-url origin git@github.com:kaycebasques/cli.git
