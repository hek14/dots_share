# To profile zsh startup time
# 1. Inject profiling code
#
# 	At the beginning of your .zshrc add following: ```zmodload zsh/zprof```
#
# 	and at the end add:
# 	```zprof```
#
# 	This will load zprof mod and display what your shell 	was doing durung your initialization.
#
# 2. Measure startup time
# 	
# 	```time  zsh -i -c exit```

. "$HOME/.config/zsh/function.zsh"
. "$HOME/.config/zsh/env.zsh"
. "$HOME/.config/zsh/alias.zsh"
. "$HOME/.config/zsh/color.zsh"
. "$HOME/.config/zsh/opt.zsh"
. "$HOME/.config/zsh/zinit.zsh"
. "$HOME/.config/zsh/tool.zsh"
. "$HOME/.config/zsh/bind.zsh"
echo "Training!!!"
