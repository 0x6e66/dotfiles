# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh configuration.
ZSH="$HOME/.local/share/sheldon/repos/github.com/ohmyzsh/ohmyzsh"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
plugins=(
    colored-man-pages
    colorize
    command-not-found
    docker
    docker-compose
    fancy-ctrl-z
    fzf
    git
    httpie
    man
    nmap
    pip
    poetry
    python
    safe-paste
    ssh-agent
    thefuck
   
    zsh-syntax-highlighting
) 

# Add your SSH key to your ssh-agent for better integration
zstyle :omz:plugins:ssh-agent helper ksshaskpass
zstyle :omz:plugins:ssh-agent identities id_ed25519 
zstyle ':completion:*' special-dirs false 

# Autocomplete hidden files
# setopt globdots

# Extend History Size
HISTSIZE=10000000
SAVEHIST=10000000

# add custom bin folder in your home for your scripts, go binaries and archpkgs to your PATH
PATH="$HOME/bin:/home/$USER/.cargo/bin:$HOME/go/bin:$HOME/.local/bin:/opt/archpkgs/bin:$PATH"


############################ exports ############################

# fzf
export FZF_DEFAULT_OPTS='--multi --no-height --extended --bind ctrl-a:select-all,ctrl-d:deselect-all,ctrl-t:toggle-all'
export EDITOR="nvim"



############################ p10k ############################

# load all other plugins via sheldon
eval "$(sheldon source)"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh



############################ aliases ############################

# Virtualenv Aliases
alias mvenv="python -m venv .venv && source .venv/bin/activate"
alias lvenv="source .venv/bin/activate"

# Neovim
alias v="nvim"
alias vim="nvim"

# We use paru instead of yay 
alias yay="paru"

# Alias to grep for IPs 
alias gip="grep -oE --color=never '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}'"

# Grab the ip of given interface
alias myip='function _myip(){ ip addr show $1 | grep --color=never "inet " | awk "{print \$2}" | cut -d/ -f1 | tr -d "\n"; }; _myip'

# Clipboard shortcuts for Wayland
alias clip="wl-copy"
alias paste="wl-paste"

# exa looks better
alias ls="exa --group-directories-first -g"

alias df='df -h'
alias rm='rm -I'
alias du='du -sh'
alias ..='cd ..'

# bat is the better cat
alias cat="bat --paging=never"
export BAT_STYLE="grid,header"

# git
git config --global alias.graph 'log --all --decorate --oneline --graph'
alias gs="git status"
alias gm="git commit "
alias gp="git push"
alias gd="git diff"
alias ga="git add"
alias gg="git graph"

############################ zsh-syntax-highlighting ############################

typeset -A ZSH_HIGHLIGHT_STYLES

ZSH_HIGHLIGHT_HIGHLIGHTERS+=(brackets)

ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=cyan'
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=cyan'

ZSH_HIGHLIGHT_STYLES[cursor-matchingbracket]='bg=none'
