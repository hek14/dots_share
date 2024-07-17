ext=$(echo $1 | awk -F '.' '(NF>1){print $NF}')

case $ext in 
  "md" ) $EDITOR $1 ;;
  "txt" ) $EDITOR $1 ;;
  "lua" ) $EDITOR $1 ;;
  "vim" ) $EDITOR $1 ;;
  "c" ) $EDITOR $1 ;;
  "py" ) $EDITOR $1 ;;
  "h" ) $EDITOR $1 ;;
  * ) open $1;;
esac  
