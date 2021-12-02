# Oh My Zsh Configuration
export ZSH="/Users/genesis/.oh-my-zsh"

# Altough it is the default theme, is my favorite theme
ZSH_THEME="robbyrussell"

HYPHEN_INSENSITIVE="true"

ENABLE_CORRECTION="true"

COMPLETION_WAITING_DOTS="true"

# Latin America Date Format
HIST_STAMPS="dd//mm/yyyy"

plugins=(
  git 
  history 
  history-substring-search
  zsh-autosuggestions
)

export CLICOLOR=1

source $ZSH/oh-my-zsh.sh

source /Users/genesis/Downloads/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Add my aliases
source $HOME/.aliases

# Cool Functions
source $HOME/.functions

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/genesis/workspace/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/genesis/workspace/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/genesis/workspace/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/genesis/workspace/google-cloud-sdk/completion.zsh.inc'; fi

export PATH="/usr/local/sbin:$PATH"

export PNPM_HOME="/Users/genesis/Library/pnpm"

export PATH="$PNPM_HOME:$PATH"
