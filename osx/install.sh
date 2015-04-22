#!/usr/bin/env bash

if [ "$(uname -s)" == "Darwin" ]; then
  dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

  source "$dir/defaults.sh"
  source "$dir/.brew.sh"
fi