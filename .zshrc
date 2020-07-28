# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"
# ZSH_THEME=”powerline”

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Uncomment this to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment following line if you want to  shown in the command execution time stamp 
# in the history command output. The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|
# yyyy-mm-dd
# HIST_STAMPS="mm/dd/yyyy"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

export PATH="/usr/X11R6/bin:/usr/local/git/bin:/Applications/Xcode.app/Contents/Developer/usr/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/local/git/bin:/Users/luyi/.rvm/bin"
# export MANPATH="/usr/local/man:$MANPATH"

# # Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# expansion command line without running it directly
# shopt -s histverify

#&# file to keep history 
export HISTFILE=~/.zshell_history

#如果连续输入的命令相同，历史纪录中只保留一个
setopt HIST_IGNORE_DUPS

#为历史纪录中的命令添加时间戳
#setopt EXTENDED_HISTORY
#export HISTTIMEFORMAT='%b %d %I:%M:%S %p '
export HISTTIMEFORMAT='%F %T  '

#doesn't log commands more than once
export HISTCONTROL=erasedups

export HISTSIZE=4500
HISTFILESIZE=4500

#&# enable cd command history, cd -[TAB]
setopt AUTO_PUSHD
#&# keep only one same path
setopt PUSHD_IGNORE_DUPS
 
#在命令前添加空格，不将此命令添加到纪录文件中
#setopt HIST_IGNORE_SPACE

# enable coloring of terminal
export CLICOLOR=1
export LSCOLORS=exfxcxdxgxegedabagacad
# export LSCOLORS=GxFxCxDxBxegedabagaced
# export LSCOLORS=ExcxBxDxGxegedabagacad

#&# alias to assume safe  
alias cp="cp -i"
alias rm="rm -i"
alias mv='mv -i'

alias h=history
alias ..="cd .."
alias j="jobs"

#&# 'ls' alias 
alias la='ls -al'          # show hidden files
alias ll="ls -l"
alias lc="ls -altr"

#&# 
alias vv="vi -R"

#&# swi-prolog
alias swipl="/opt/local/bin/swipl"
alias gcc="/usr/bin/gcc"

#&# QT qmake
#alias qmake="/Users/apple/QtSDK/Desktop/Qt/4.8.0/gcc/bin/qmake"

#&# bash configure my multi-line prompt
#PS1='\[\e[0;35m\]\u@\h: \w \$\n\[\e[m\]'

#load colors
autoload -U colors && colors
for COLOR in RED GREEN YELLOW BLUE MAGENTA CYAN BLACK WHITE; do
    eval $COLOR='%{$fg_no_bold[${(L)COLOR}]%}'  #wrap colours between %{ %} to avoid weird gaps in autocomplete
    #eval BOLD_$COLOR='%{$fg_bold[${(L)COLOR}]%}'
done
eval RESET='%{$reset_color%}'
#&# PS1="%{$fg[red]%}%n%{$reset_color%}@%{$fg[blue]%}%m %{$fg[yellow]%}%~ %{$reset_color%}%% "

PS1="%{$fg_bold[magenta]%}[%n@%m]%{$reset_color%} %~ %{$fg_bold[magenta]%}%%
%{$reset_color%}"

#PS1="%{$fg[cyan]%}%B%m%b%u%{$reset_color%}:%{$fg[green]%}%2~%{$fg[magenta]%}%%%{$reset_color%} "

#-----#
# X11 #
#-----#
# export DISPLAY=:0.0

#&# show hidden files or not
# defaultswrite com.apple.finder AppleShowAllFiles -bool [true|false]

export PERL_LOCAL_LIB_ROOT="/Users/luyi/perl5:$PERL_LOCAL_LIB_ROOT";
export PERL_MB_OPT="--install_base "/Users/luyi/perl5"";
export PERL_MM_OPT="INSTALL_BASE=/Users/luyi/perl5";
export PERL5LIB="/Users/luyi/perl5/lib/perl5:$PERL5LIB";
export PATH="/Users/luyi/perl5/bin:$PATH";

# Python
export PYTHONSTARTUP="/Users/luyi/.pythonstartup"
alias python3="/usr/local/bin/python3"


