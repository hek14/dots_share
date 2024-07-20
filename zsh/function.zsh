function command_exists() {
  command -v "${1}" > /dev/null
  return $?
}

function export_proxy() {
  export http_proxy="http://127.0.0.1:$1"
  export https_proxy=$http_proxy
  export all_proxy=$http_proxy
  export HTTP_PROXY=$http_proxy
  export HTTPS_PROXY=$http_proxy
  export ALL_PROXY=$http_proxy
}

function set_proxy() {
  local port=${1:-33210}
  export_proxy $port
  zsh -c "sed -r 's/(http.*):([0-9]+)/\1:$port/g' ~/.gitconfig > ~/.gitconfig.tmp && mv ~/.gitconfig.tmp ~/.gitconfig"
}

export_proxy 33210

function unset_proxy() {
  while read var;do echo "unset $var";unset $var;done < <(env | grep -i proxy | grep -v -i "^no" | grep -v -i "^go" | cut -d '=' -f 1)
}

function restart_proxy() {
  ps aux | grep -i 'udpraw' | grep -v grep | awk '{print $2}' | xargs -I % kill -9 %
  ps aux | grep -i 'hysteria' | grep -v grep | awk '{print $2}' | xargs -I % kill -9 %
  sudo ~/Documents/Technique/gfw/mac/udp2raw/udp2raw_mp_mac_m1 -c -l0.0.0.0:3333  -r139.84.163.31:4096 -k "passwd" --raw-mode faketcp > ~/udpraw.log 2>&1 &
  ~/Documents/Technique/gfw/mac/hysteria/hysteria-darwin-arm64 client -c config.json > ~/hysteria.log 2>&1 &
}

function refresh_env {
  export $(tmux show-environment | grep "^SSH_AUTH_SOCK")
  export $(tmux show-environment | grep "^DISPLAY")
}

function pathadd() {
  new="${1}"
  if [ -d "${new}" ]; then
    if [[ ":${PATH}:" != *":${new}:"* ]]; then
      PATH="${new}:${PATH}"
    fi
  fi
}

function unset_conda_path(){
  export PATH=$(echo $PATH | sed "s/:/\n/g" | sed '/conda/d' | sed ':a;N;$!ba;s/\n/:/g')
}

function comet_upload() {
  export COMET_API_KEY=nCkC7ey16xmbouOaVUXjawPmY && unset_proxy ; comet upload $1 --force-reupload
}

function conda_activate() {
  conda activate $1
  export VIRTUAL_ENV=$HOME"/miniconda3/envs/$1"
}

function stats_lines () {
  fd "\.$1" | awk 'BEGIN{sum=0}; {val=0;  while((getline ln < $0)>0){if (ln !~ "^ *$"){val=val+1}};  print $0 ":  " val;sum=sum+val}; END{print("total lines: ",sum)}'
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

function mkcd() { 
  mkdir -p "$@" && cd "$_"; 
}

function rp { 
  echo $(cd $(dirname $1); pwd)/$(basename $1); 
}

function tn(){ 
  tmux new -A -s $1 
}

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

function tl(){ 
  tmux ls 
}

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

function magit(){
  if [[ ! -z $1 ]]; then
    cd $1
  fi
  emacsclient -a -nw -e "(magit-status)"
}

function lr () {
  ls -al | grep -i $1
}

function update_pip_all() {
        for VERSION in $(pyenv versions --bare) ; do
            pyenv shell ${VERSION} ;
            pip install -i https://pypi.tuna.tsinghua.edu.cn/simple pip -U
        done
}

function pf {
  ps aux | fzf --bind "ctrl-k:execute(echo {} | awk '{print \$2}' | xargs -I % kill -9 %)+accept"
}

function rgv () {
  rg -i --line-number $@ | fzf | xargs -r echo | {read line ; file=`echo $line | cut -d : -f 1`; line=`echo $line | cut -d : -f 2`; nvim $file '+autocmd! BufReadPost' +$line}
}

function last(){
  echo `ls -1 -tr | tail -1`
}

function DD() {
  python -m debugpy --wait-for-client --log-to-stderr --listen 127.0.0.1:5678 $1
}


function c(){
  mkdir $1 ; cp ./CMakeLists.txt $1/ ; cd $1
}

# function vv(){
#   nvim $@
#   ps aux | grep -i '\(pylance\|pyright\|headless\)' | grep -v 'grep' | awk '{print $2}' | xargs -I % kill -9 %
#   if [ $? -eq 55 ] 
#   then 
#     vv $@
#   else 
#     echo "quit vv"
#   fi
# }

function vv(){
  nvim $@
  if [ $? -eq 55 ] 
  then 
    vv $@
  else
    cwd=$(cat /tmp/cwd.txt)
    cd $cwd
  fi
}

function mvv(){
  nvim --server /tmp/nvim.sock --remote "$(realpath $@)"
}

function Man(){
  nvim --clean -u NONE -c "source $HOME/.config/nvim/minimal_init.lua | Man $1 | exe \"normal! \<C-w>\<C-o>\""
}
function qingdao96(){
  {lsof -i :5996 | awk '(NR>1){print $2}'  | awk '!a[$0]++' | xargs -I {} kill -9 {}} && ssh -N -f -L 5996:localhost:5996 qingdao && open vnc://127.0.0.1:5996
}
