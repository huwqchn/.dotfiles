#!/usr/bin/env bash

set -o noclobber -o noglob -o nounset -o pipefail
IFS=$'\n'

## Meanings of exit codes:
## code | meaning	| action of joshuto
## -----+------------+-------------------------------------------
## 0	| success	| Display stdout as preview
## 1	| no preview	| Display no preview at all
## 2	| plain text	| Display the plain content of the file
## 3	| fix width 	| Don't reload when width changes
## 4	| fix height	| Don't reload when height changes
## 5	| fix both	| Don't ever reload
## 6	| images	| Display the image `$IMAGE_CACHE_PATH` points to as an image preview
## 7	| images	| Display the file directly as an image

FILE_PATH=""
PREVIEW_IMAGE_ENABLED=0
PREVIEW_WIDTH=10
PREVIEW_HEIGHT=10
PREVIEW_X_COORD=0
PREVIEW_Y_COORD=0
IMAGE_CACHE_PATH=""

# echo "$@"

while [ "$#" -gt 0 ]; do
	case "$1" in
		"--path")
			shift
			FILE_PATH="$1"
			;;
		"--preview-width")
			shift
			PREVIEW_WIDTH="$1"
			;;
		"--preview-height")
			shift
			PREVIEW_HEIGHT="$1"
			;;
		"--x-coord")
			shift
			PREVIEW_X_COORD="$1"
			;;
		"--y-coord")
			shift
			PREVIEW_Y_COORD="$1"
			;;
		"--preview-images")
			shift
			PREVIEW_IMAGE_ENABLED="$1"
			;;
		"--image-cache")
			shift
			IMAGE_CACHE_PATH="$1"
			;;
	esac
	shift
done

FILE_EXTENSION="${FILE_PATH##*.}"
FILE_EXTENSION_LOWER="$(printf "%s" "${FILE_EXTENSION}" | tr '[:upper:]' '[:lower:]')"

MIMETYPE=$(file --mime-type -Lb "${FILE_PATH}")

## Settings
HIGHLIGHT_SIZE_MAX=262143  # 256KiB
HIGHLIGHT_TABWIDTH="${HIGHLIGHT_TABWIDTH:-8}"
HIGHLIGHT_STYLE="${HIGHLIGHT_STYLE:-pablo}"
HIGHLIGHT_OPTIONS="--replace-tabs=${HIGHLIGHT_TABWIDTH} --style=${HIGHLIGHT_STYLE} ${HIGHLIGHT_OPTIONS:-}"
PYGMENTIZE_STYLE="${PYGMENTIZE_STYLE:-autumn}"
OPENSCAD_IMGSIZE="${RNGR_OPENSCAD_IMGSIZE:-1000,1000}"
OPENSCAD_COLORSCHEME="${RNGR_OPENSCAD_COLORSCHEME:-Tomorrow Night}"

handle_extension() {
	local file_extension="${1}"

	case "$file_extension" in
		## Archive
		a|ace|alz|arc|arj|bz|bz2|cab|cpio|deb|gz|jar|lha|lz|lzh|lzma|lzo|\
		rpm|rz|t7z|tar|tbz|tbz2|tgz|tlz|txz|tZ|tzo|war|xpi|xz|Z|zip)
			atool --list -- "${FILE_PATH}" && exit 5
			bsdtar --list --file "${FILE_PATH}" && exit 5
			exit 1;;
		rar)
			## Avoid password prompt by providing empty password
			unrar lt -p- -- "${FILE_PATH}" && exit 5
			exit 1;;
		7z)
			## Avoid password prompt by providing empty password
			7z l -p -- "${FILE_PATH}" && exit 5
			exit 1;;

		## PDF
		## pdf)
		## Preview as text conversion
		## pdftotext -l 10 -nopgbrk -q -- "${FILE_PATH}" - | \
		##    fmt -w "${PREVIEW_WIDTH}" && exit 5
		## mutool draw -F txt -i -- "${FILE_PATH}" 1-10 | \
		##    fmt -w "${PREVIEW_WIDTH}" && exit 5
		##    exiftool "${FILE_PATH}" && exit 5
		##    exit 1;;

		## BitTorrent
		torrent)
			transmission-show -- "${FILE_PATH}" && exit 5
			exit 1;;

		## OpenDocument
		odt|ods|odp|sxw)
			## Preview as text conversion
			odt2txt "${FILE_PATH}" && exit 5
			## Preview as markdown conversion
			pandoc -s -t markdown -- "${FILE_PATH}" && exit 5
			exit 1;;

		## XLSX
		xlsx)
			## Preview as csv conversion
			## Uses: https://github.com/dilshod/xlsx2csv
			xlsx2csv -- "${FILE_PATH}" && exit 5
			exit 1;;

		## HTML
		htm|html|xhtml)
			## Preview as text conversion
			w3m -dump "${FILE_PATH}" && exit 5
			lynx -dump -- "${FILE_PATH}" && exit 5
			elinks -dump "${FILE_PATH}" && exit 5
			pandoc -s -t markdown -- "${FILE_PATH}" && exit 5
			exit 1;;

		## JSON
		json|ipynb)
			jq --color-output . "${FILE_PATH}" && exit 5
			python -m json.tool -- "${FILE_PATH}" && exit 5
			exit 1;;

		## Direct Stream Digital/Transfer (DSDIFF) and wavpack aren't detected
		## by file(1).
		dff|dsf|wv|wvc)
			mediainfo "${FILE_PATH}" && exit 5
			exiftool "${FILE_PATH}" && exit 5
			exit 1;;
	esac
	# Continue with next handler on no match
}

handle_image() {
	## Size of the preview if there are multiple options or it has to be
	## rendered from vector graphics. If the conversion program allows
	## specifying only one dimension while keeping the aspect ratio, the width
	## will be used.
	local DEFAULT_SIZE="40x30"

	local mimetype="${1}"
	case "${mimetype}" in
		## Image
		image/*)
			# kitty +kitten icat --clear
			kitty +kitten icat \
				--transfer-mode file \
				--place "${PREVIEW_WIDTH}x${PREVIEW_HEIGHT}@${PREVIEW_X_COORD}x${PREVIEW_Y_COORD}" \
				"${FILE_PATH}"
			exit 7
			;;
	esac
}

handle_mime() {
	local mimetype="${1}"

	case "${mimetype}" in
		## RTF and DOC
		text/rtf|*msword)
			## Preview as text conversion
			## note: catdoc does not always work for .doc files
			## catdoc: http://www.wagner.pp.ru/~vitus/software/catdoc/
			catdoc -- "${FILE_PATH}" && exit 5
			exit 1;;

		## DOCX, ePub, FB2 (using markdown)
		## You might want to remove "|epub" and/or "|fb2" below if you have
		## uncommented other methods to preview those formats
		*wordprocessingml.document|*/epub+zip|*/x-fictionbook+xml)
			## Preview as markdown conversion
			pandoc -s -t markdown -- "${FILE_PATH}" && exit 5
			exit 1;;

		## E-mails
		message/rfc822)
			## Parsing performed by mu: https://github.com/djcb/mu
			mu view -- "${FILE_PATH}" && exit 5
			exit 1;;

		## XLS
		*ms-excel)
			## Preview as csv conversion
			## xls2csv comes with catdoc:
			##   http://www.wagner.pp.ru/~vitus/software/catdoc/
			xls2csv -- "${FILE_PATH}" && exit 5
			exit 1;;

		## Text
		text/* | */xml)

			bat --paging=never \
				--color=always \
				--style=plain \
				--terminal-width="${PREVIEW_WIDTH}" \
				 "${FILE_PATH}" 2>&1
			exit 5
			exit 1;;

		## DjVu
		image/vnd.djvu)
			## Preview as text conversion (requires djvulibre)
			djvutxt "${FILE_PATH}" | fmt -w "${PREVIEW_WIDTH}" && exit 5
			exiftool "${FILE_PATH}" && exit 5
			exit 1;;

		## Image
		image/*)
			## Preview as text conversion
			# img2txt --gamma=0.6 --width="${PREVIEW_WIDTH}" -- "${FILE_PATH}" && exit 4
			exiftool "${FILE_PATH}" && exit 5
			exit 1;;

		## Video and audio
		##  video/* | audio/*)
		##  mediainfo "${FILE_PATH}" && exit 5
		##  exiftool "${FILE_PATH}" && exit 5
		##  exit 1;;
	esac
}

handle_fallback() {
	# echo '----- File Type Classification -----' && file --dereference --brief -- "${FILE_PATH}" && exit 5
	exit 1
}

if [[ "${PREVIEW_IMAGE_ENABLED}" -eq 1 ]]; then
	handle_image "${MIMETYPE}"
fi

handle_extension "${FILE_EXTENSION_LOWER}"
handle_mime "${MIMETYPE}"
handle_fallback

exit 1
