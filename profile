# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# If running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	  . "$HOME/.bashrc"
    fi
fi

# Set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.bin" ] ; then
    export PATH="$HOME/.bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ] ; then
    export PATH="$HOME/.local/bin:$PATH"
fi

if [ -d "$HOME/.local/sbin" ] ; then
    export PATH="$HOME/.local/sbin:$PATH"
fi

# Add Composer's vendor/bin to PATH
if [ -d "$HOME/.composer/vendor/bin" ] ; then
    export PATH="$HOME/.composer/vendor/bin:$PATH"
fi
if [ -d "$HOME/.config/composer/vendor/bin" ] ; then
    export PATH="$HOME/.config/composer/vendor/bin:$PATH"
fi

# Prepend NPM's and Yarn's bin folders to PATH if needed
if [ -d "$HOME/.npm/bin" ] ; then
    export PATH="$HOME/.npm/bin:$PATH"
fi

# Include Yarn paths
if [ -d "$HOME/.yarn/bin" ] ; then
    export PATH="$HOME/.yarn/bin:$PATH"
fi
if [ -d "$HOME/.config/yarn/global/node_modules/.bin" ] ; then
    export PATH="$HOME/.config/yarn/global/node_modules/.bin:$PATH"
fi
