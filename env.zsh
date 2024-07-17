if [[ -n $TMUX ]] then
  export PATH="/Users/hk/.local/share/nvim/lazy/vim-floaterm/bin/floaterm:$PATH"
fi
pathadd "$HOME/.local/bin"
pathadd "$ANDROID_HOME/cmdline-tools/latest/bin"
pathadd "/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
pathadd "/opt/homebrew/opt/llvm/bin"
pathadd "$HOME/.local/share/bob/nvim-bin"
pathadd "$HOME/.cargo/bin"
pathadd "$HOME/.config/zsh/scripts"

export HISTSIZE=500000
export SAVEHIST=500000
export KEYTIMEOUT=1 # 10ms for key sequences

export ANDROID_HOME='/Users/hk/Library/Android/sdk'
# export JAVA_OPTS='-XX:+IgnoreUnrecognizedVMOptions --add-modules java.se.ee'
# export DISPLAY=localhost:0.0

# https://github.com/junegunn/fzf/issues/1593#issuecomment-498007983
# interactive programs such as vim/nvim/less  read from STDIN assuming it's a TTY device, so you need to redirect STDIN (and STDOUT) when it's not.
export FZF_DEFAULT_OPTS='--multi --bind "ctrl-g:execute(my_open.sh {})+abort" --color=dark --bind "ctrl-y:execute-silent(echo -n {+} | clippy set)+abort"'
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
  --color=dark
  --color=fg:-1,bg:-1,hl:#5fff87,fg+:-1,bg+:-1,hl+:#ffaf5f
  --color=info:#af87ff,prompt:#5fff87,pointer:#ff87d7,marker:#ff87d7,spinner:#ff87d7'

export DISTANT_LOG_FILE="/Users/hk/distant.log"
export DISTANT_LOG_LEVEL="trace"

# brew installed llvm
# export LDFLAGS="-L/opt/homebrew/opt/llvm/lib/c++ -Wl,-rpath,/opt/homebrew/opt/llvm/lib/c++"
export LDFLAGS="-L/opt/homebrew/opt/llvm/lib"
export CPPFLAGS="-I/opt/homebrew/opt/llvm/include"
