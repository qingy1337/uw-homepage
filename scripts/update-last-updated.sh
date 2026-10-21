#!/bin/sh

set -eu

repo_root=$(git rev-parse --show-toplevel)
page="$repo_root/index.html"
UPDATED_MONTH_YEAR=$(LC_ALL=C date "+%B %Y")
export UPDATED_MONTH_YEAR

if ! grep -Eq 'Last updated [A-Za-z]+ [0-9]{4}\.' "$page"; then
    echo "Could not find the Last updated date in index.html." >&2
    exit 1
fi

perl -0pi -e 's/(Last updated )[A-Za-z]+ [0-9]{4}\./$1$ENV{UPDATED_MONTH_YEAR}./g' "$page"

