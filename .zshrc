[[ -f ~/.keys ]] && . ~/.keys

export PATH="$HOME/.local/bin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"

# Proxy function that sources the setproxy script
function setproxy() {
    source ~/.local/bin/setproxy
    # Add proxy indicator to prompt
    export PS1_PROXY_INDICATOR="$PS1_PROXY_INDICATOR(proxy)"
    update_prompt
}

function unsetproxy() {
    unset http_proxy https_proxy no_proxy
    # Remove proxy indicator from prompt
    unset PS1_PROXY_INDICATOR
    update_prompt
    echo "Proxy settings removed"
}

# Function to update prompt with proxy indicator
function update_prompt() {
    if [[ -n "$PS1_PROXY_INDICATOR" ]]; then
        export PS1="%{$fg[blue]%}$PS1_PROXY_INDICATOR%{$reset_color%} $PS1_ORIGINAL"
    else
        export PS1="$PS1_ORIGINAL"
    fi
}

# Store original prompt and set up initial prompt
if [[ -z "$PS1_ORIGINAL" ]]; then
    export PS1_ORIGINAL="$PS1"
    update_prompt
fi

function setkimi() {
    export ANTHROPIC_BASE_URL=https://api.kimi.com/coding/
    export ANTHROPIC_API_KEY="$ANTHROPIC_API_KEY_VAR"
    export PS1_PROXY_INDICATOR="$PS1_PROXY_INDICATOR(kimi-cc)"
    update_prompt
    echo "Kimi API enabled"
}

function setclaude() {
    unset ANTHROPIC_BASE_URL
    export ANTHROPIC_API_KEY="$ANTHROPIC_API_KEY_VAR"
    export PS1_PROXY_INDICATOR="$PS1_PROXY_INDICATOR(claude)"
    update_prompt
    echo "Claude API enabled"
}

function setzai() {
    source ~/.local/bin/setzai
}

# Android SDK (用户目录)
export ANDROID_HOME="$HOME/android-sdk"
export PATH="$ANDROID_HOME/cmdline-tools/latest/bin:$PATH"
export PATH="$ANDROID_HOME/platform-tools:$PATH"
export PATH="$ANDROID_HOME/emulator:$PATH"

# Flutter China mirror
function set_cnflutter() {
    export PUB_HOSTED_URL=https://pub.flutter-io.cn
    export FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn
    export PS1_PROXY_INDICATOR="$PS1_PROXY_INDICATOR(cn_flutter)"
    update_prompt
}

function unset_cnflutter() {
    unset PUB_HOSTED_URL FLUTTER_STORAGE_BASE_URL
    unset CHROME_EXECUTABLE
}

# Aliases
alias rm='trash-put'
alias docker='podman'
alias vim='nvim'

# Proxy exclusions
export NO_PROXY="localhost,127.0.0.1"
export no_proxy="localhost,127.0.0.1"

# Additional paths
export PATH=$PATH:$HOME/.maestro/bin
