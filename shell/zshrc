# Oh My Zsh Configuration
export ZSH="$HOME/.oh-my-zsh"

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
plugins+=(nx-completion)

export CLICOLOR=1

source $ZSH/oh-my-zsh.sh

source $HOME/.config/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Add my aliases
source $HOME/.aliases

# Cool Functions
source $HOME/.functions

export PATH="/usr/local/sbin:$PATH"
export PATH=$PATH:/opt/local/bin
export PATH=$PATH:$HOME/bin

export PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true
export PUPPETEER_EXECUTABLE_PATH=`which chromium`

export GOPATH=$HOME/go
export GOROOT="$(brew --prefix golang)/libexec"
export PATH="$PATH:${GOPATH}/bin:${GOROOT}/bin"
export PATH="$HOME/Library/Python/3.8/bin:$PATH"
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
export PATH="/opt/homebrew/opt/mysql-client/bin:$PATH"

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

export EDITOR=nvim
export VISUAL=nvim

# API keys and secrets are loaded from secrets.zsh
# Copy secrets.example.zsh to secrets.zsh and fill in your API keys


# Load secrets (API keys, tokens, etc.)
if [ -f "$HOME/.secrets.zsh" ]; then
    source $HOME/.secrets.zsh
else
    echo "Warning: ~/.secrets.zsh not found. Copy secrets.example.zsh to secrets.zsh and add your API keys."
fi

export PATH=$PATH:$HOME/Downloads/boost_1_83_0

export PATH=$PATH:$HOME/Downloads/openmaptiles/pre/osmium-tool/build/bin

export MODULAR_HOME="$HOME/.modular"
export PATH="$MODULAR_HOME/pkg/packages.modular.com_mojo/bin:$PATH"

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

export CLOUDSDK_PYTHON="/usr/bin/python3"
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"

# Created by `pipx` on 2024-06-18 07:20:47
export PATH="$PATH:$HOME/.local/bin"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '$HOME/workspace/google-cloud-sdk/path.zsh.inc' ]; then . '$HOME/workspace/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '$HOME/workspace/google-cloud-sdk/completion.zsh.inc' ]; then . '$HOME/workspace/google-cloud-sdk/completion.zsh.inc'; fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

if [ -f "$HOME/.config/fabric/fabric-bootstrap.inc" ]; then . "$HOME/.config/fabric/fabric-bootstrap.inc"; fi

# Alisses for all patterns
# Loop through all files in the ~/.config/fabric/patterns directory
for pattern_file in $HOME/.config/fabric/patterns/*; do
    # Get the base name of the file (i.e., remove the directory path)
    pattern_name=$(basename "$pattern_file")
    if [[ "$pattern_name" == "ai" ]]; then
        continue
    fi

    # Create an alias in the form: alias pattern_name="fabric --pattern pattern_name"
    alias_command="alias $pattern_name='fabric --pattern $pattern_name'"

    # Evaluate the alias command to add it to the current shell
    eval "$alias_command"
done

yt() {
    local video_link="$1"
    fabric -y "$video_link" --transcript
}

# Added by LM Studio CLI (lms)
export PATH="$PATH:$HOME/.lmstudio/bin"

# set -o vi

# Task Master aliases added on 5/3/2025
alias tm='task-master'
alias taskmaster='task-master'


setopt completealiases
alias claude="$HOME/.claude/local/claude"

# opencode
export PATH=$HOME/.opencode/bin:$PATH
export PATH=$HOME/.docker/bin:$PATH
