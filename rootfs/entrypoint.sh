#!/bin/bash

set -euo pipefail

function ensure_group() {
    if ! GROUPNAME="$(getent group "${1}" | grep -o '^[^:]*')"
    then
        GROUPNAME=debian
        groupadd -g "${PGID}" "${GROUPNAME}" >&2
    fi

    echo "${GROUPNAME}"
}

function ensure_user() {
    if ! USERNAME="$(getent passwd "${1}" | grep -o '^[^:]*')"
    then
        USERNAME=debian
        useradd -u "${1}" -g "${2}" "${USERNAME}" >&2
    fi

    echo "${USERNAME}"
}

function last_backup() {
    ls -1 "${BACKUP_DIR}"/[0-9_.]*.tar.gz 2> /dev/null | tail -n1
}

PUID="${PUID:-0}"
PGID="${PGID:-0}"

PGROUP="$(ensure_group "${PGID}")"
PUSER="$(ensure_user "${PUID}" "${PGID}")"

BACKUP_DIR=/backup
INPUT_DIR=/input
LAST_EXTRACT="${INPUT_DIR}/last-extract"

echo "${PUSER} ALL=(ALL) NOPASSWD: ALL" > "/etc/sudoers.d/${PUSER}"

if [ -n "${EXTRACT_LAST_BACKUP:-}" ]
then
    if LAST_BACKUP="$(last_backup)"
    then
        if [ ! -e "${LAST_EXTRACT}" -o "${LAST_BACKUP}" != "$(cat "${LAST_EXTRACT}")" ]
        then
            sudo -u "${PUSER}" -g "${PGROUP}" /extract.sh "${LAST_BACKUP}"
        else
            echo "No changes" >&2
            exit 0
        fi
    else
        echo "No backup" >&2
        exit 0
    fi
fi

exec sudo -u "${PUSER}" -g "${PGROUP}" mapcrafter "${@}"
