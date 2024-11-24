#!/bin/sh -l

commands=""

i=1
for local_dir in $INPUT_LOCALDIR; do
	remote_dir=$(echo $INPUT_REMOTEDIR | cut -d' ' -f$i)
    commands="$commands mirror $INPUT_OPTIONS --reverse --continue --dereference -x ^\.git/$ $local_dir $remote_dir;"
	i=$((i + 1))
done

lftp $INPUT_HOST -u $INPUT_USER,$INPUT_PASSWORD -e "set ftp:ssl-force $INPUT_FORCESSL; set ssl:verify-certificate false; $commands quit"
