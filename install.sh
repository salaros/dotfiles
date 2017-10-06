#!/bin/bash

nocolor=$'\e[0m'
bold=$(tput bold)                         # make colors bold/bright
red="$bold$(tput setaf 1)"                # bright red text
green=$(tput setaf 2)                     # dim green text
fawn=$(tput setaf 3); beige="$fawn"       # dark yellow text
yellow="$bold$fawn"                       # bright yellow text
darkblue=$(tput setaf 4)                  # dim blue text
blue="$bold$darkblue"                     # bright blue text
purple=$(tput setaf 5); magenta="$purple" # magenta text
pink="$bold$purple"                       # bright magenta text
darkcyan=$(tput setaf 6)                  # dim cyan text
cyan="$bold$darkcyan"                     # bright cyan text
gray=$(tput setaf 7)                      # dim white text
darkgray="$bold"$(tput setaf 0)           # bold black = dark gray text
white="$bold$gray"                        # bright white text

# Create a backup folder for existing configs
if [ ! -d ~/.var/backup ]; then
	mkdir -pv ~/.var/backup/dotfiles
fi

# Backuping existing and ${pink}REAL${red} dotfiles and removing symlinked dotfiles
printf "${red}Backuping existing and ${pink}REAL${red} dotfiles (and removing symlinked dotfiles)\n\n"
shopt -u dotglob
for file in *; do
    dotfile="$HOME/.$(basename $file)"
    # If file exists and it's a symlink it will be REMOVED
    if [ -f $dotfile ] && [ -L $dotfile ]; then
        rm -fv $dotfile
    # Otherwise (if it's a real file) it will be moved to backups
    elif [ -f $dotfile ]; then
        mv -v $dotfile ~/.var/backup/dotfiles
    fi
done;
printf "${white}[\u2713] Done!\n\n${nocolor}"

# Install Bash-related files via symlinks
printf "${purple}Bash-related configs\n\n"
for file in $(pwd)/{aliases,dircolors,inputrc,bash_completion,bashrc,bash_prompt,bash_tweaks,profile}; do
	ln -sv "$file" "$HOME/.$(basename $file)"
done;
printf "${white}[\u2713] Done!\n\n${nocolor}"

# Install Git and editor-related files via symlinks
printf "${blue}Git and editor-related configs\n\n"
for file in $(pwd)/{editorconfig,gitignore,gitattributes,gitconfig}; do
	ln -sv "$file" "$HOME/.$(basename $file)"
done;
printf "${white}[\u2713] Done!\n\n${nocolor}"

# Install wget and cURL-related files via symlinks
printf "${darkblue}wget and cURL-related configs\n\n"
for file in $(pwd)/{curlrc,wgetrc}; do
	ln -sv "$file" "$HOME/.$(basename $file)"
done;
printf "${white}[\u2713] Done!\n\n${nocolor}"

# Reloading the bash with new settings
source ~/.bashrc && echo "${yellow}Reloading the ${pink}Bash${yellow} with new settings!${nocolor}" && exec bash
