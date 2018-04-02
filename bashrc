# $HOME/.bashrc: executed by bash(1) for non-login shells.

# If not running interactively, don't do anything
case $- in
    *i*) ;;
        *) return;;
esac

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi

# Exports environment variables
[[ -f $HOME/.exports ]] && . $HOME/.exports

# Set some bash options and apply some tweaks
[[ -f $HOME/.bash_tweaks ]] && . $HOME/.bash_tweaks

# More command completion
[[ -f $HOME/.bash_completion ]] && . $HOME/.bash_completion

# Alias definitions
[[ -f $HOME/.aliases ]] && . $HOME/.aliases

# Coloring the bash here
[[ -f $HOME/.bash_prompt ]] && . $HOME/.bash_prompt

# Set host-specific config
[[ -f $HOME/.bashrc.$HOSTNAME ]] && . $HOME/.bashrc.$HOSTNAME

# WakaTime for terminal
[[ -f $HOME/.bash-wakatime/bash-wakatime.sh ]] && . $HOME/.bash-wakatime/bash-wakatime.sh

# Starts SSH agent and all available loads identities
# as a workaround for Bash running on WSL (Windows Subsystem for Linux)
if [ -d "$HOME/.ssh" ] && [ $(ps ax | grep [s]sh-agent | wc -l) -le 5 ]; then
  # Fix file permissions for SSH keys
  chmod 600 $HOME/.ssh/id_* > /dev/null 2>&1
  chmod 755 $HOME/.ssh/ > /dev/null 2>&1

  # Start SSH agent
  eval `ssh-agent` > /dev/null 2>&1 && ssh-add > /dev/null 2>&1;
fi
