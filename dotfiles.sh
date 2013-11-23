#!/usr/bin/env bash
# Install dotfiles into home directory

#base="$(dirname ${BASH_SOURCE})"
base=$( cd "$( dirname "${BASH_SOURCE}" )" && pwd )
echo $base

echo -e "\033[1m\033[4mLinking\033[0m"
dotfiles=(
	.bashrc 
	.bash_profile
	.gitconfig
	.gitignore_global
	.inputrc
	.vimrc
	)
for file in "${dotfiles[@]}"; do
	dest="${HOME}/${file}"
	if [ -L $dest ]; then
		echo -e " \033[0;33m✖\033[0m $dest (already linked)"
	else
		if [ -e $dest ]; then
			echo -e " \033[1;31m✖\033[0m $dest (file exists)"
		else
			ln -s "$base/$file" $dest && echo -e " \033[1;32m➜\033[0m $dest"
		fi
	fi
done

echo -e "\033[1;32m✔\033[0m Done, restarting login shell";
exec $SHELL -l
