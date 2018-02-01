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
        printf "";
    # Otherwise (if it's a real file) it will be moved to backups
    elif [ -f $dotfile ]; then
        mv -v $dotfile ~/.var/backup/dotfiles
    # Treating a special case below: a symlink pointing to inexistent file
    elif [ ! -d $dotfile ]; then
        rm -fv $dotfile
    fi
done;

# Link all folders (except 'config') to $HOME
for folder in `find ./* -maxdepth 1 -type d -not -name "config"`
do
    dotfolder="$HOME/.$(basename $folder)"
    if [ -d $dotfolder ] && [ ! -L $dotfolder ]; then
        cp -rfvaup $dotfolder ~/.var/backup/dotfolder && rm -rfv $dotfolder
    fi
done

# Link all folders from config to ~/.config
for folder in `find ./config/ -maxdepth 1 -type d`
do
    dotfolder="$HOME/.config/$(basename $folder)"
    if [ -d $dotfolder ] && [ ! -L $dotfolder ]; then
        cp -rfvaup $dotfolder ~/.var/backup/dotfolder && rm -rfv $dotfolder
    fi
done

printf "${white}[\u2713] Done!\n\n${nocolor}"

# Install Bash-related files via symlinks
printf "${purple}Bash-related configs\n\n"
for file in $(pwd)/{aliases,exports,dircolors,bash_completion,bashrc,bash_prompt,bash_tweaks,profile,hidden}; do
	ln -sfv "$file" "$HOME/.$(basename $file)"
done;
printf "${white}[\u2713] Done!\n\n${nocolor}"

# Install screen, input and session-related stuff
printf "${fawn}Screen, input and session-related stuff\n\n"
for file in $(pwd)/{drirc,inputrc,screenrc,xbindkeysrc,xinputrc,xsession}; do
	ln -sfv "$file" "$HOME/.$(basename $file)"
done;
printf "${white}[\u2713] Done!\n\n${nocolor}"

# Install Git-related files via symlinks
printf "${blue}Git-related configs\n\n"
for file in $(pwd)/{gitignore,gitattributes,gitconfig}; do
	ln -sfv "$file" "$HOME/.$(basename $file)"
done;
printf "${white}[\u2713] Done!\n\n${nocolor}"

# Install development and editor-related files via symlinks
printf "${yellow}Development and editor-related configs\n\n"
for file in $(pwd)/{editorconfig,npmrc,yarnrc}; do
	ln -sfv "$file" "$HOME/.$(basename $file)"
done;
printf "${white}[\u2713] Done!\n\n${nocolor}"

# Install wget and cURL-related files via symlinks
printf "${darkblue}wget and cURL-related configs\n\n"
for file in $(pwd)/{curlrc,wgetrc}; do
	ln -sfv "$file" "$HOME/.$(basename $file)"
done;
printf "${white}[\u2713] Done!\n\n${nocolor}"

# Install .bin folder, containing some useful executables
printf "${cyan}~/.bin folder for executables\n"
[[ ! -L "$HOME/.bin" ]] && ln -sfv $(pwd)/bin "$HOME/.bin"
printf "${white}[\u2713] Done!\n\n${nocolor}"

# Install .config folder for app configs
printf "${darkcyan}~/.config folder for app configs\n"
for folder in `find $(pwd)/config/* -maxdepth 1 -type d`
do
	dotfolder="$HOME/.config/$(basename $folder)"
    ln -sfv $folder $dotfolder
done
printf "${white}[\u2713] Done!\n\n${nocolor}"

# Install devilspie and other tweaks via symlinks
printf "${green}Devilspie and other tweaks\n"
[[ ! -L "$HOME/.devilspie" ]] && ln -sfv $(pwd)/devilspie "$HOME/.devilspie"
(killall -q devilspie; command -v devilspie >/dev/null 2>&1 && devilspie -d && killall -q devilspie)&
if [ ! -f "$HOME/.config/autostart/devilspie.desktop" ]; then
    command -v devilspie >/dev/null 2>&1 && echo "[Desktop Entry]
    Name=Devilspie
    Exec=/usr/bin/devilspie
    Terminal=false
    Type=Application
    X-Gnome-Autostart=true" > $HOME/.config/autostart/devilspie.desktop
    printf "${white}[\u2713] Done!\n\n${nocolor}"
fi

# Unset variables set by this script
unset -v file folder dotfile dotfolder

# Reloading the bash with new settings
source ~/.profile && echo "${yellow}Reloading the ${pink}Bash${yellow} with new settings!${nocolor}" && exec bash
