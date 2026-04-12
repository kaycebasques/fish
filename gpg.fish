#!/usr/bin/fish

# Enable keygen over SSH
# https://superuser.com/a/521027
sudo apt install pinentry-tty
set GPG_CONF $HOME/.gnupg/gpg-agent.conf
if not test -f $GPG_CONF
    touch $GPG_CONF
end
set PIN "pinentry-program /usr/bin/pinentry-tty"
if not grep -Fxq "$PIN" "$GPG_CONF"
    echo "$PIN" >> "$GPG_CONF"
end
gpg-connect-agent reloadagent /bye

gpgconf --kill gpg-agent
gpg --full-generate-key
gpg --list-secret-keys --keyid-format=long
read -P "Enter the **ed25519** **sec**ret ID:" key_id
gpg --armor --export $key_id
echo "TODO: Add the key to https://github.com/settings/gpg/new"
git config --global user.signingkey $key_id

cd $HOME/cli
git config --local commit.gpgsign true
