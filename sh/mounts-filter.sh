#!/bin/bash
set -euo pipefail

# Usage:
#   $0 {path-to/custom.mounts.list} < project.yaml > output.yaml
#
# Requires:
#   - sed
#
# Applies custom additions (that are not within the version control) to the YAML, before being passed on to Lima VM.
#

CUSTOM_MOUNTS="${1:-}"

if [ -z "${CUSTOM_MOUNTS}" ]; then
  echo -e >&2 "\nUsage: $0 {path to custom.mounts.list}"
  exit 1
fi

if [ ! -f "${CUSTOM_MOUNTS}" ]; then
  echo -e >&2 "\nMissing '${CUSTOM_MOUNTS}'"
  exit 1
fi

# Stage 1.
#
# Filter out 'mounts: null'.
#
# This is applied on the script's input, passing it on with the minor change.
#
#sed 's/^mounts:[[:space:]]*null/#mounts: null/g'
cat

initial=true

while IFS= read -r line || [ -n "$line" ]; do
    # Remove comments
    host_path="${line%%#*}"

    # Trim white space
    host_path="$(echo "${host_path}" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')"
      # macOS 'sed' note:
      #   It does not support '+' (1..); use '*' (0..).

    # Skip empty lines
    if [ -z "${host_path}" ]; then
        continue
    fi

    # Pick the last part of path for 'mountPoint'. e.g. "~/Abc/Def" -> "Def", "/Users/john/Yyy/" -> "Yyy"
    tmp="${host_path%/}"
    last_part="${tmp##*/}"

    if [ $initial = true ]; then
        echo ""
        echo "mounts:"
        initial=false
    fi
    echo "  - location: \"${host_path}\""
    echo "    mountPoint: \"{{.Home}}/${last_part}\""
    echo "    writable: true"

done < "${CUSTOM_MOUNTS}"

if [ $initial = true ]; then
  echo ""
  echo "mounts: null"
fi
