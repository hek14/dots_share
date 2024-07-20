bindkey -v
bindkey ^A beginning-of-line
bindkey ^E end-of-line
bindkey ^B backward-char
bindkey ^F forward-char
bindkey ^U backward-kill-line
bindkey ^Y yank

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
bindkey -M viins "^X^E" edit-command-line
bindkey -M vicmd "^X^E" edit-command-line
