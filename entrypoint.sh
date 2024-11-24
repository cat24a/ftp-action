#!/bin/bash -l

commands=""

local_dirs=($INPUT_LOCALDIR)
remote_dirs=($INPUT_REMOTEDIR)

for ((i=0;i<${#local_dirs[@]};i++))
do
    commands="$commands mirror $INPUT_OPTIONS --reverse --continue --dereference -x ^\.git/$ ${local_dirs[$i]} ${remote_dirs[$i]};"
done

lftp $INPUT_HOST -u $INPUT_USER,$INPUT_PASSWORD -e "set ftp:ssl-force $INPUT_FORCESSL; set ssl:verify-certificate false; $commands quit"
