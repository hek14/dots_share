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

command_exists tmuxifier
if [ "${?}" -eq "0" ]; then
  export PATH="$PATH:$HOME/.tmux/plugins/tmuxifier/bin"
  eval "$(tmuxifier init -)"
fi

# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"

if [[ ! -d  ~/.fzf/ ]]; then
  echo "need to install fzf"
  echo "git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf"
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  echo "~/.fzf/install"
  ~/.fzf/install
fi
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
unset CONDA_SHLVL
__conda_setup="$('/Users/hk/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/hk/miniconda3/etc/profile.d/conda.sh" ]; then
# . "/Users/hk/miniconda3/etc/profile.d/conda.sh"  # commented out by conda initialize
    else
# export PATH="/Users/hk/miniconda3/bin:$PATH"  # commented out by conda initialize
    fi
fi
unset __conda_setup
