export PATH=$(echo $PATH | sed "s/:/\n/g" | sed '/conda/d' | sed ':a;N;$!ba;s/\n/:/g')
