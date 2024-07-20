# alias messages='emacsclient -nw -e \(message "$(git rev-parse --show-toplevel)"\)'
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
alias mvim="nvim --clean -u NONE \"+source $HOME/.config/nvim/minimal_init.lua\"" # minimal nvim
if type "floaterm" > /dev/null; then
  alias vi="floaterm"
else
  if type "nvim" > /dev/null; then
      alias vi=mvim
  else
      alias vi="vim"
  fi
fi

alias icat="kitty +kitten icat"
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
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree $HOME'
alias luamake=/home/hk/contrib/lua-language-server/3rd/luamake/luamake
alias kcp='/Users/hk/Documents/Technique/gfw/mac/client_darwin_arm64 -l :6666 -r 158.247.203.104:29900 -key kkhui -mtu 1400 -sndwnd 256 -rcvwnd 2048 -mode fast2'
alias udp='sudo ~/Documents/Technique/gfw/mac/udp2raw/udp2raw_mp_mac_m1 -c -l0.0.0.0:3456  -r45.32.118.19:4096 -k "kkxxy" --raw-mode faketcp'
alias hy='~/Documents/Technique/gfw/mac/hysteria/hysteria-darwin-amd64 client -c ~/Documents/Technique/gfw/mac/hysteria/config_sg.json'
alias rsync="/opt/homebrew/bin/rsync"
