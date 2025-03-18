# zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/zinit/zinit.git"

# Download zinit if it's not already installed
if [[ ! -d $ZINIT_HOME ]]; then
    mkdir -p "$(dirname $ZINIT_HOME)"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source zinit
source "${ZINIT_HOME}/zinit.zsh"

# Plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab
zinit light kutsan/zsh-system-clipboard

# Snippets
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::archlinux
zinit snippet OMZP::command-not-found

# Load completions
autoload -U compinit && compinit

zinit cdreplay -q

# Completion settings
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:*' fzf-preview
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview

# Keybindings
bindkey "^?" backward-delete-char
bindkey '^a' autosuggest-accept
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey -s '^e' 'vim $(fzf)\n'
bindkey -s '^f' '~/.scripts/tmux-sessionizer.sh\n'
bindkey -s '^b' '~/.scripts/dev-tools.sh\n'
bindkey -s '^g' 'echo -n "grep: "; read param && rg $param | fzf\n'
bindkey -v

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_find_no_dups

# Aliases
alias ls='ls --color'
alias vim=nvim
alias vi=nvim
alias neofetch=fastfetch
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias mpv='mpv --force-window'

# Shell integrations
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"

# oh-my-posh
eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/config.toml)"

# bun completions
[ -s "/home/tomi/.bun/_bun" ] && source "/home/tomi/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# API keys
load_api_keys() {
    local secrets_dir="$HOME/.secrets"

    if [[ ! -d "$secrets_dir" ]]; then
        return
    fi

    for file in "$secrets_dir"/*; do
        if [[ -f "$file" ]]; then
            local varname=$(basename "$file")
            export "$varname=$(cat "$file")"
        fi
    done
}
load_api_keys
