# ~/.bashrc: executed by bash(1) for non-login shells.

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
[[ -f ~/.exports ]] && . ~/.exports

# Set some bash options and apply some tweaks
[[ -f ~/.bash_tweaks ]] && . ~/.bash_tweaks

# More command completion
[[ -f ~/.bash_completion ]] && . ~/.bash_completion

# Alias definitions
[[ -f ~/.aliases ]] && . ~/.aliases

# Coloring the bash here
[[ -f ~/.bash_prompt ]] && . ~/.bash_prompt

# Set host-specific config
[[ -f ~/.bashrc.$HOSTNAME ]] && . ~/.bashrc.$HOSTNAME

# Starts SSH agent and all available loads identities
# as a workaround for Bash running on WSL (Windows Subsystem for Linux)
eval `ssh-agent` > /dev/null 2>&1 && ssh-add > /dev/null 2>&1
