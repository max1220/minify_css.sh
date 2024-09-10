#!/bin/bash
set -euo pipefail

# first argument is a path to a directory to minify CSS source files from
dir_path="${1%/}"
[ -d "${dir_path}" ]

# get list of source files
css_files=("${dir_path%/}"/[0-9][0-9][0-9]_*.css)

if [ -z "${2:-}" ]; then # just concatenate and exit
	cat "${css_files[@]}";
	exit 0
else # concatenate to file and possibly process further(see below)
	>&2 printf "'%q'\n" "${css_files[@]}"
	cat "${css_files[@]}" > "${2}"
	>&2 echo "Concatenated size: $(wc -c "${2}")"
fi

# optionally minify
if [ -n "${3:-}" ]; then
	sed "/\/\*.*\*\//d;/\/\*/,/\*\// d" "${2}" | tr -d "\t" | tr -d "\n" > "${3}"
	sed -i "s/: /:/g" "${3}"
	sed -i "s/ {/{/g" "${3}"
	sed -i "s/ > />/g" "${3}"
	>&2 echo "Minified size: $(wc -c "${3}")"
fi

# optionally gzip
if [ -n "${4:-}" ]; then
	gzip --best < "${3}" > "${4}"
	>&2 echo "gzip'ed size: $(wc -c "${4}")"
fi