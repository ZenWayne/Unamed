[[ -f ~/.keys ]] && . ~/.keys
export PATH="$HOME/.local/bin:$PATH"

# Android SDK（用户目录）
export ANDROID_HOME="$HOME/android-sdk"
export PATH="$ANDROID_HOME/cmdline-tools/latest/bin:$PATH"
export PATH="$ANDROID_HOME/platform-tools:$PATH"
export PATH="$ANDROID_HOME/emulator:$PATH"

setproxy() {
    export http_proxy=http://127.0.0.1:10809
    export https_proxy=http://127.0.0.1:10809
    export HTTP_PROXY=http://127.0.0.1:10809
    export HTTPS_PROXY=http://127.0.0.1:10809
    export PS1="(proxy) $PS1"
    echo "Proxy enabled: http://127.0.0.1:10809"
}

unsetproxy() {
    unset http_proxy https_proxy HTTP_PROXY HTTPS_PROXY
    export PS1="${PS1#(proxy) }"
    echo "Proxy disabled"
}
alias rm='trash-put'
alias docker='podman'
export PATH=$PATH:$HOME/.maestro/bin

setkimi() {
    export ANTHROPIC_BASE_URL=https://api.kimi.com/coding/
    export ANTHROPIC_API_KEY="$ANTHROPIC_API_KEY_VAR"
    echo "Kimi API enabled"
}

set_cnflutter(){
  export PUB_HOSTED_URL=https://pub.flutter-io.cn
  export FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn
    export PS1="${PS1#(cn_flutter) }"
}
unset_cnflutter(){
    unset CHROME_EXECUTABLE
}

export NO_PROXY="localhost,127.0.0.1"
export no_proxy="localhost,127.0.0.1"
