# ~/.zshrc - Modern minimal Zsh configuration with Catppuccin Mocha

# PATH setup - prevent duplicates
typeset -U path PATH
path=(
    $HOME/.local/bin
    $HOME/.bun/bin
    $HOME/.cargo/bin
    $HOME/bin
    $path
)
export PATH

# Environment / NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# History
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt SHARE_HISTORY
setopt APPEND_HISTORY

# Directory navigation options
setopt AUTO_CD
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_SILENT

# Completion system
autoload -Uz compinit
compinit -d "$HOME/.zcompdump"
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# Vi Mode & Keybindings
bindkey -v
export KEYTIMEOUT=1

# Word navigation (Ctrl + Left / Right) & standard line editing
bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word
bindkey '^[[3~' delete-char
bindkey '^?' backward-delete-char
bindkey '^H' backward-delete-char
bindkey '^W' backward-kill-word
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line
bindkey '^K' kill-line
bindkey '^U' backward-kill-line

# Fix Ctrl+Left/Right in Vi Command Mode as well
bindkey -M vicmd '^[[1;5D' backward-word
bindkey -M vicmd '^[[1;5C' forward-word

# Edit current command line in Neovim (Tekan 'v' saat di Vi Normal Mode)
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M vicmd 'v' edit-command-line

# Plugins
# 1. zsh-autosuggestions (Catppuccin Mocha Surface2 #585b70 suggestion style)
if [ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
    source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
    ZSH_AUTOSUGGEST_STRATEGY=(history completion)
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#585b70"
    # Accept suggestion with Ctrl+Right or Ctrl+E
    bindkey '^[[1;5C' forward-word
fi

# 2. zsh-syntax-highlighting (Catppuccin Mocha palette)
if [ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
    source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    typeset -A ZSH_HIGHLIGHT_STYLES
    ZSH_HIGHLIGHT_STYLES[comment]='fg=#6c7086'
    ZSH_HIGHLIGHT_STYLES[alias]='fg=#89b4fa,bold'
    ZSH_HIGHLIGHT_STYLES[suffix-alias]='fg=#89b4fa,bold'
    ZSH_HIGHLIGHT_STYLES[builtin]='fg=#cba6f7,bold'
    ZSH_HIGHLIGHT_STYLES[function]='fg=#89b4fa'
    ZSH_HIGHLIGHT_STYLES[command]='fg=#89b4fa,bold'
    ZSH_HIGHLIGHT_STYLES[precommand]='fg=#cba6f7,italic'
    ZSH_HIGHLIGHT_STYLES[commandseparator]='fg=#f5c2e7'
    ZSH_HIGHLIGHT_STYLES[path]='fg=#94e2d5'
    ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=#fab387'
    ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=#fab387'
    ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=#a6e3a1'
    ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=#a6e3a1'
fi

# Aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias ll='ls -lah'
alias la='ls -A'
alias l='ls -CF'

# Starship prompt initialization
if command -v starship >/dev/null 2>&1; then
    eval "$(starship init zsh)"
fi
