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

# Set some bash options and apply some tweaks
[[ -f ~/.bash_tweaks ]] && . ~/.bash_tweaks

# More command completion
[[ -f ~/.bash_completion ]] && . ~/.bash_completion

# Alias definitions
[[ -f ~/.bash_aliases ]] && . ~/.bash_aliases

# Coloring the bash here
[[ -f ~/.bash_colors ]] && . ~/.bash_prompt

# Set host-specific config
[[ -f ~/.bashrc.$HOSTNAME ]] && . ~/.bashrc.$HOSTNAME
