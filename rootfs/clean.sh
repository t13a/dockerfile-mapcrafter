#!/bin/bash

set -euo pipefail

INPUT_DIR=/input

echo "Cleaning..." >&2
rm -rf "${INPUT_DIR}"/*
echo "Clean completed" >&2
