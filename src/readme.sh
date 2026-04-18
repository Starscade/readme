#!/bin/sh

README=''

if test -f './README'; then
	README='./README'
fi

if test -f './README.md'; then
	README='./README.md'
fi

if test -f './README.txt'; then
	README='./README.txt'
fi

if test -n "$1"; then
	README="$1"
fi

sed \
    -e 's/<\([^>]*\)>//g' \
    -e 's/\[!\([^]]*\)\]/\x1b[91m\1\x1b[0m/g' \
    -e 's/!\[\([^]]*\)\]([^)]*)/\x1b[30;47m \1 \x1b[0m/g' \
    -e 's/\[\([^]]*\)\](\([^)]*\))/\x1b[94m\1 \x1b[0;90m[\x1b[0;34m\2\x1b[0;90m]\x1b[0m/g' \
    -e 's/^\[!\(.*\)*\]$/\1/' \
    -e 's/^# \(.*\)/\x1b[1;4;93m━ \U\1\E ━\x1b[0m\n/' \
    -e 's/^#\{2,5\} \(.*\)/\x1b[1;93m━ \1 ━\x1b[0m/' \
    -e 's/^#\{6\} \(.*\)/\x1b[1;93m━ \1 ━\x1b[0m/' \
    -e 's/\*\*\([^*]*\)\*\*/\x1b[1m\1\x1b[0m/g' \
    -e 's/\*\([^*]*\)\*/\x1b[3m\1\x1b[0m/g' \
    -e 's/__\([^*]*\)__/\x1b[4m\1\x1b[0m/g' \
    -e 's/\~\([^~]~\)\*/\x1b[9m\1\x1b[0m/g' \
    -e 's/| /\t/g' \
    -e 's/ |$//' \
    -e 's/```//g' \
    -e 's/^[[{]/\x1b[32m&/' \
    -e 's/^[]}]/&\x1b[0m/' \
    -e 's/`\([^`]*\)`/\x1b[32m\1\x1b[0m/g' \
    -e 's/^> \(.*\)/\t\1/' \
    -e 's/^ *[-+*] *\(.*\)/\t• \1/' \
    -e "s/^---$/\n \x1b[0;90m$(printf '%*s' $(( $(tput cols) - 2 )) | tr ' ' '`')\x1b[0m\n/" \
    -e 'y/`/━/' \
    -e 's/  +//g' \
    "$README" \
    | sed -z 's/\n  *//g'
