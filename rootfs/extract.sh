#!/bin/bash

set -euo pipefail

INPUT_DIR=/input
LAST_EXTRACT="${INPUT_DIR}/last-extract"
LAST_BACKUP="${1}"

# TODO Wait for complete if last backup is in process of creation.

echo "Cleaning..." >&2
rm -rf "${INPUT_DIR}"/*
echo "Clean completed" >&2

cd "${INPUT_DIR}"

echo "${LAST_BACKUP}: Extracting..." >&2
tar -xf "${LAST_BACKUP}"
echo "${LAST_BACKUP}: Extract completed" >&2

echo "${LAST_BACKUP}" > "${LAST_EXTRACT}"
