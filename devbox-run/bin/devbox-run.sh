#!/bin/sh

devbox run -- true
returncode=$?
if [ "$returncode" != 0 ]; then
	printf 'ERR: devbox init error detected: %s\n' "$returncode" 1>&2
	exit "$returncode"
fi

_realpath_outside_devbox="$(realpath -- "$0")"
_realpath_inside_devbox="$(realpath -- "$(devbox run -- which -- "$(basename -- "$0")")")"
if [ "$_realpath_inside_devbox" = "$_realpath_outside_devbox" ]; then
	printf 'ERR: unproductive recursive exec detected\n' 1>&2
	printf 'ERR:   %s %s\n' "$0" "$*" 1>&2
	exit 40
fi

devbox run -- execline-cd "$PWD" "$(basename -- "${0}")" "$@"
returncode=$?
if [ "$returncode" != 0 ]; then
	printf 'ERR: devbox run error detected: %s\n' "$returncode" 1>&2
	exit "$returncode"
fi
exit 127
