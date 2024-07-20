HISTSIZE=500000
SAVEHIST=500000
setopt appendhistory
setopt INC_APPEND_HISTORY  
setopt SHARE_HISTORY



ZSH_THEME="starship"
## check if given command exists on the system
function command_exists() {
  command -v "${1}" > /dev/null
  return $?
}

function set_proxy() {
  port=8877
  export http_proxy="http://localhost:$port"
  export https_proxy=$http_proxy
  export all_proxy=$http_proxy
  export HTTP_PROXY=$http_proxy
  export HTTPS_PROXY=$http_proxy
  export ALL_PROXY=$http_proxy
}
set_proxy

function unset_proxy() {
	while read var;do echo "unset $var";unset $var;done < <(env | grep -i proxy | grep -v -i "^no" | grep -v -i "^go" | cut -d '=' -f 1)
}

# for nix to work in tmux
if [[ -n $TMUX ]] && [[ $OSTYPE =~ "darwin" ]]; then
  # PATH=""
  # source /etc/profile
  export PATH="$HOME/.nix-profile/bin:/nix/var/nix/profiles/default/bin:$PATH"
  export PATH="/Users/hk/.local/share/nvim/lazy/vim-floaterm/bin/floaterm:$PATH"
  function refresh_env {
    export $(tmux show-environment | grep "^SSH_AUTH_SOCK")
    export $(tmux show-environment | grep "^DISPLAY")
  }
fi
export PATH=$HOME/.local/bin:$PATH
### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
        print -P "%F{33}‚ñì‚ñí‚ñë %F{220}Installing DHARMA Initiative Plugin Manager (zdharma-continuum/zinit)‚Ä¶%f"
        command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
        command git clone https://github.com/zdharma-continuum/zinit "$HOME/.zinit/bin" && \
                print -P "%F{33}‚ñì‚ñí‚ñë %F{34}Installation successful.%f" || \
                print -P "%F{160}‚ñì‚ñí‚ñë The clone has failed.%f"
fi
source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

stats_lines ()
{
  fd "\.$1" | awk 'BEGIN{sum=0}; {val=0;  while((getline ln < $0)>0){if (ln !~ "^ *$"){val=val+1}};  print $0 "  " val;sum=sum+val}; END{print("total: ",sum)}'
}

if [[ $ZSH_THEME == "pure" ]];then
  zinit ice pick"async.zsh" src"pure.zsh" atload"zstyle ':prompt:pure:prompt:*' color cyan"
  zinit light sindresorhus/pure
fi

# Oh-my-zsh plugins
# zinit snippet OMZ::lib/history.zsh
zinit ice lucid wait'0'
zinit light joshskidmore/zsh-fzf-history-search

zinit snippet OMZ::lib/key-bindings.zsh

zinit ice wait lucid
zinit snippet OMZ::lib/completion.zsh

zinit ice wait lucid
zinit snippet OMZ::lib/grep.zsh

# Oh-my-zsh plugins
zinit ice wait lucid atload"unalias grv"
zinit snippet OMZ::plugins/git/git.plugin.zsh

zinit ice wait lucid
zinit snippet OMZ::plugins/colored-man-pages/colored-man-pages.plugin.zsh

zinit ice wait lucid
zinit snippet OMZ::plugins/systemd/systemd.plugin.zsh

zinit ice wait lucid
zinit snippet OMZ::plugins/sudo/sudo.plugin.zsh

zinit ice wait lucid
zinit snippet OMZ::plugins/extract/extract.plugin.zsh

zinit ice wait lucid
zinit snippet OMZ::plugins/systemadmin/systemadmin.plugin.zsh

#### no longer needed, replace by zoxide
# zinit ice wait lucid
# zinit load agkozak/zsh-z 

# Plugins
zinit ice depth=1 lucid
zinit light trystan2k/zsh-tab-title

zinit ice depth=1 wait lucid
zinit light Aloxaf/fzf-tab # replace zsh default completion

zinit ice wait'0' lucid; zinit light sainnhe/zsh-completions

zinit ice depth=1 wait lucid atinit"ZINIT[COMPINIT_OPTS]=-C; zpcompinit; zpcdreplay"
zinit light zdharma-continuum/fast-syntax-highlighting

zinit ice depth=1 wait lucid compile"{src/*.zsh,src/strategies/*.zsh}" atload"_zsh_autosuggest_start"
zinit light zsh-users/zsh-autosuggestions

zinit ice depth=1 wait lucid atload"bindkey '$terminfo[kcuu1]' history-substring-search-up; bindkey '$terminfo[kcud1]' history-substring-search-down"
zinit light zsh-users/zsh-history-substring-search

zinit ice depth=1 wait lucid atload"alias mm=mark; alias jm=jump; alias lm=lmarks; alias dm=dmarks; alias cm=cmarks"
zinit light wfxr/formarks

zinit ice depth=1 wait"1" lucid pick"manydots-magic" compile"manydots-magic"
zinit light knu/zsh-manydots-magic

zinit ice depth=1 wait"1" lucid atinit"zstyle ':history-search-multi-word' page-size '20'"
zinit light zdharma-continuum/history-search-multi-word

zinit ice depth=1 wait"2" lucid
zinit light wfxr/forgit

zinit ice depth=1 wait"2" lucid
zinit light hlissner/zsh-autopair

zinit ice depth=1 wait"2" lucid
zinit light peterhurford/up.zsh

zinit ice depth=1 wait"2" lucid
zinit light MichaelAquilina/zsh-you-should-use

# functions
function pathadd() {
  new="${1}"
  if [ -d "${new}" ]; then
    if [[ ":${PATH}:" != *":${new}:"* ]]; then
      PATH="${new}:${PATH}"
    fi
  fi
}

function tb_run() {
  spec=""
  cnt=0
  port=8001
  for var in "$@"
  do
    cnt=$cnt+1
    if [[ $((cnt%2)) == 1 ]]; then
      spec="${spec}${var}:"
    else
      spec="${spec}${var},"
    fi
  done
  let "len=${#spec} - 1" # math here is not the same as cnt=$cnt+1, because ${#spec} here is a string
  spec=$(echo $spec | cut -c1-$len)
  tensorboard --logdir_spec $spec --port $port
}

function comet_upload() {
  export COMET_API_KEY=nCkC7ey16xmbouOaVUXjawPmY && unset_proxy ; comet upload $1 --force-reupload
}

function conda_activate() {
  conda activate $1
  export VIRTUAL_ENV=$HOME"/miniconda3/envs/$1"
}
function mkcd() { mkdir -p "$@" && cd "$_"; }
function realpath { echo $(cd $(dirname $1); pwd)/$(basename $1); }
function rp { echo $(cd $(dirname $1); pwd)/$(basename $1); }
function tn(){ tmux new -A -s $1 }
function ta(){
  if [ -z "$1" ]
  then
    tmux attach-session -t $(tmux list-sessions | sed -E 's/:.*$//' | fzf --reverse)
  else
    tmux attach-session -t $1
  fi
}
function tk(){
  if [ -z "$1" ]
  then
    tmux kill-session -t $(tmux list-sessions | sed -E 's/:.*$//' | fzf --reverse)
  else
    tmux attach-session -t $1
  fi
}
function tl(){ tmux ls }
function ksync () {
  local_dir=$1
  remote_dir=$2
  if [ ${local_dir: -1} != "/" ]; then
    local_dir=$local_dir"/"
  fi
  echo "start syncing files under $local_dir with $remote_dir"
  when-changed -r $local_dir -c rsync -avc --progress $local_dir $remote_dir
}
function clear_packer() {
  rm ~/.local/share/nvim/site/lua/_compiled.lua
}
# function magit(){
#   if [[ ! -z $1 ]]; then
#     cd $1
#   fi
#   emacsclient -a -nw -e "(magit-status)"
# }

# alias messages='emacsclient -nw -e \(message "$(git rev-parse --show-toplevel)"\)'
function lr () {
  ls -al | grep -i $1
}
# function update_pip_all() {
#         for VERSION in $(pyenv versions --bare) ; do
#             pyenv shell ${VERSION} ;
#             pip install -i https://pypi.tuna.tsinghua.edu.cn/simple pip -U
#         done
# }
# binds
bindkey -v
KEYTIMEOUT=1 # 10ms for key sequences
bindkey ^A beginning-of-line
bindkey ^E end-of-line
bindkey ^B backward-char
bindkey ^F forward-char
bindkey -M vicmd "h" vi-backward-char
bindkey -M vicmd "n" down-line-or-history
bindkey -M vicmd "e" up-line-or-history
bindkey -M vicmd "i" vi-forward-char
bindkey -M vicmd "k" vi-repeat-search
bindkey -M vicmd "K" vi-rev-repeat-search
bindkey -M vicmd "l" undo
bindkey -M vicmd "u" vi-insert
bindkey -M viins "^d" delete-char

bindkey -M viopp "uw" select-in-word
bindkey -M viopp "uW" select-in-blank-word
bindkey -M viopp "ua" select-in-shell-word
bindkey -M viopp "n" down-line
bindkey -M viopp "e" up-line

# autoload -z edit-command-line
# zle -N edit-command-line
bindkey -M viins "^X^E" edit-command-line
bindkey -M vicmd "^X^E" edit-command-line

### pyenv setup
# if [[ ! -d $HOME/.pyenv ]]; then
#     print "installing pyenv"
#     command git clone https://github.com/pyenv/pyenv.git $HOME/.pyenv && \
#     command  cd ~/.pyenv && src/configure && command make -C src
#     print "pyenv installation done"
# fi
# export PYENV_ROOT="$HOME/.pyenv"
# export PATH="$PYENV_ROOT/bin:$PATH"
# eval "$(pyenv init -)"
# source $(pyenv root)/completions/pyenv.zsh

### pyenv virtualenv setup
# if [[ ! -d $PYENV_ROOT/plugins/pyenv-virtualenv ]]; then
#     print "installing pyenv-virtualenv plugin"
#     command git clone https://github.com/pyenv/pyenv-virtualenv.git $PYENV_ROOT/plugins/pyenv-virtualenv && \
#     print "installation done"
# fi
# eval "$(pyenv virtualenv-init -)"

### direnv setup
# if ! type "direnv" > /dev/null; then
#     print "installing direnv"
#     command yay -S direnv
#     print "installation done"
# fi
# eval "$(direnv hook zsh)"

# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"

# zoxide to replace z
command_exists zoxide
if [ "${?}" -eq "0" ]; then
  eval "$(zoxide init zsh --cmd z)"
fi

# aliases
command_exists lsd
if [ "${?}" -eq "0" ]; then
  alias ls="lsd"
else
  command_exists exa
  if [ "${?}" -eq "0" ]; then
    alias ls="exa"
  else
    alias ls='ls --color=auto'
  fi
fi
alias kill_udp="ps aux | grep -i 'udp2raw_mp_mac' | grep -v grep | awk '{print $2}' | xargs -I % sudo kill -9 %"
alias kill_hy="ps aux | grep -i 'hysteria-darwin' | grep -v grep | awk '{print $2}' | xargs -I % sudo kill -9 %"

alias lt="ls -lhtr"
alias ll="ls -lh"
alias la="ls -alh"
if type "floaterm" > /dev/null; then
  alias vi="floaterm"
else
  if type "nvim" > /dev/null; then
      alias vi="nvim"
  else
      alias vi="vim"
  fi
fi

alias icat="kitty +kitten icat"
function pf {
  ps aux | fzf --bind "ctrl-k:execute(echo {} | awk '{print \$2}' | xargs -I % kill -9 %)+accept"
}
alias pk="ps aux | fzf -e -m | awk '{print \$2}' | xargs -I % kill -9 %"
alias zt="z -t"
alias pgrep="pgrep -f -i"
alias setclip="xclip -selection c"
alias getclip="xclip -selection c -o"
alias gs="gpustat"
alias p="pwd"
alias reload="source ~/.zshrc"
alias e="emacsclient -c"
alias tb='tensorboard'
alias cl='clear'
alias lg="lazygit"
alias mysu="sudo su -c \"bash --rcfile <(echo '. ~/.bashrc; unset HISTFILE')\""
alias magit='emacsclient -a emacs -nw -e "(progn (magit-status \"$(git rev-parse --show-toplevel)\") (delete-other-windows))"'
# alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree $HOME'
alias luamake=/home/hk/contrib/lua-language-server/3rd/luamake/luamake
function rgv () {
  rg -i --line-number $@ | fzf | xargs -r echo | {read line ; file=`echo $line | cut -d : -f 1`; line=`echo $line | cut -d : -f 2`; nvim $file '+autocmd! BufReadPost' +$line}
}
function last(){
  echo `ls -1 -tr | tail -1`
}

if [[ ! -d  ~/.fzf/ ]]; then
  echo "need to install fzf"
  echo "git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf"
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  echo "~/.fzf/install"
  ~/.fzf/install
fi
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
function DD() {
  python -m debugpy --wait-for-client --log-to-stderr --listen 127.0.0.1:5678 $1
}
export ANDROID_HOME='/Users/hk/Library/Android/sdk'
export PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin
export PATH=$HOME/.tmux/plugins/t-smart-tmux-session-manager/bin:$PATH
# export JAVA_OPTS='-XX:+IgnoreUnrecognizedVMOptions --add-modules java.se.ee'
alias kcp='/Users/hk/Documents/Technique/gfw/mac/client_darwin_arm64 -l :6666 -r 158.247.203.104:29900 -key kkhui -mtu 1400 -sndwnd 256 -rcvwnd 2048 -mode fast2'
export DISPLAY=localhost:0.0

# theme setup
if [[ $ZSH_THEME == "starship" ]];then
  command_exists starship
  if [ "${?}" -eq "1" ]; then
    echo 'You should install starship first following: https://starship.rs/guide/#%F0%9F%9A%80-installation'
  else
    eval "$(starship init zsh)"
  fi
fi

function unset_conda_path(){
  export PATH=$(echo $PATH | sed "s/:/\n/g" | sed '/conda/d' | sed ':a;N;$!ba;s/\n/:/g')
}

# make shell not tracking the command which starts with space
setopt HIST_IGNORE_SPACE
setopt AUTOCD


# https://github.com/junegunn/fzf/issues/1593#issuecomment-498007983
# interactive programs such as vim/nvim/less  read from STDIN assuming it's a TTY device, so you need to redirect STDIN (and STDOUT) when it's not.
export FZF_DEFAULT_OPTS='--multi --bind "ctrl-g:execute(my_open.sh {})+abort" --color=dark --bind "ctrl-y:execute-silent(echo -n {+} | clippy set)+abort"'
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
--color=dark
--color=fg:-1,bg:-1,hl:#5fff87,fg+:-1,bg+:-1,hl+:#ffaf5f
--color=info:#af87ff,prompt:#5fff87,pointer:#ff87d7,marker:#ff87d7,spinner:#ff87d7
'

function c(){
  mkdir $1 ; cp ./CMakeLists.txt $1/ ; cd $1
}

function vv(){
  nvim $@
  ps aux | grep -i '\(pylance\|pyright\|headless\)' | grep -v 'grep' | awk '{print $2}' | xargs -I % kill -9 %
  if [ $? -eq 55 ] 
  then 
    vv $@
  else 
    echo "quit vv"
  fi
}
function mvv(){
  nvim --server /tmp/nvim.sock --remote "$(realpath $@)"
}
export DISTANT_LOG_FILE="/Users/hk/distant.log"
export DISTANT_LOG_LEVEL="trace"
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/hk/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/hk/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/hk/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/hk/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
export PATH="$HOME/miniconda3/bin:$PATH" # NOTE:  this is mandatory

function restart_proxy() {
  ps aux | grep -i 'udpraw' | grep -v grep | awk '{print $2}' | xargs -I % kill -9 %
  ps aux | grep -i 'hysteria' | grep -v grep | awk '{print $2}' | xargs -I % kill -9 %
  sudo ~/Documents/Technique/gfw/mac/udp2raw/udp2raw_mp_mac_m1 -c -l0.0.0.0:3333  -r139.84.163.31:4096 -k "passwd" --raw-mode faketcp > ~/udpraw.log 2>&1 &
  ~/Documents/Technique/gfw/mac/hysteria/hysteria-darwin-arm64 client -c config.json > ~/hysteria.log 2>&1 &
}

# brew installed llvm
# export LDFLAGS="-L/opt/homebrew/opt/llvm/lib/c++ -Wl,-rpath,/opt/homebrew/opt/llvm/lib/c++"
export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
export LDFLAGS="-L/opt/homebrew/opt/llvm/lib"
export CPPFLAGS="-I/opt/homebrew/opt/llvm/include"
export PATH="$HOME/.local/share/bob/nvim-bin:$PATH"

alias gvim='NVIM_APPNAME="glepnir" nvim'
export PATH="$HOME/.cargo/bin:$PATH"

command_exists tmuxifier
if [ "${?}" -eq "0" ]; then
  export PATH="$PATH:$HOME/.tmux/plugins/tmuxifier/bin"
  eval "$(tmuxifier init -)"
fi
