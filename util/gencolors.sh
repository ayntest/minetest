#!/usr/bin/env bash
COLORS_FILE=colors.txt
NODES_FILE=nodes.txt
NODES_COUNT=$( wc -l < ${NODES_FILE} )

printf '%d nodes loaded\n' ${NODES_COUNT}
i=0
while read -r p; do
	set -- junk $p
	shift
	if [[ ! $1 == "#" && ! $1 == "" ]]; then
		printf '%s %s\n' "$1" "$( python bin/avgcolor.py $(find . -type f -name $2) )"
	fi
	>&2 printf \
		'\033[2K%d%% [%s]\r' $( perl -MPOSIX -e "print floor( $i / ${NODES_COUNT} * 100 )") "$2"
		#'\033[2K%d/%d [%s]\r' $i ${NODES_COUNT} "$2"
	let i++
done < ${NODES_FILE} > ${COLORS_FILE}

sed -re 's/^(default:water_[a-z]+) [0-9 ]+$/\1 39 66 106 128 224/' \
	-e 's/^(default:lava_[a-z]+) [0-9 ]+$/\1 255 100 0/' \
	${COLORS_FILE} > tmpcolors
mv tmpcolors ${COLORS_FILE}
