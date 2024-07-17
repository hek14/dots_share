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

ZSH_THEME="starship"
if [[ $ZSH_THEME == "pure" ]];then
  zinit ice pick"async.zsh" src"pure.zsh" atload"zstyle ':prompt:pure:prompt:*' color cyan"
  zinit light sindresorhus/pure
fi
if [[ $ZSH_THEME == "starship" ]];then
  command_exists starship
  if [ "${?}" -eq "1" ]; then
    echo 'You should install starship first following: https://starship.rs/guide/#%F0%9F%9A%80-installation'
  else
    eval "$(starship init zsh)"
  fi
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

zinit ice wait lucid
zinit load agkozak/zsh-z # better than zoxide: it has bug

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

zinit ice depth=1 wait lucid atload"alias cdu='cd-gitroot'"
zinit light mollifier/cd-gitroot
