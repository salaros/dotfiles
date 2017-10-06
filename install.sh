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

echo "${red}Backuping existent Bash configs (removing symlinks)${nocolor}"
for file in ~/.{aliases,dircolors,bash_completion,bashrc,bash_prompt,bash_tweaks,profile}; do
    # If file exists and it's a symlink it will be REMOVED
    if [ -f $file ] && [ -L $file ]; then
        rm -fv $file
    # Otherwise (if it's a real file) it will be moved to backups
    elif [ -f $file ]; then
        mv -v $file ~/.var/backup/dotfiles
    fi
done;
printf "${red}Done!${nocolor}\n\n"

# Install Bash-related files via symlinks
echo "${purple}Installing new Bash configs${nocolor}"
for file in $(pwd)/{aliases,dircolors,bash_completion,bashrc,bash_prompt,bash_tweaks,profile}; do
	ln -sv "$file" "$HOME/.$(basename $file)"
done;
printf "${purple}Done!${nocolor}\n\n"

# Reloading the bash with new settings
source ~/.bashrc && echo "${yellow}Reloading the ${pink}Bash${yellow} with new settings!${nocolor}" && exec bash
