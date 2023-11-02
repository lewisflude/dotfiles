#!/bin/sh
if  command -v asdf >/dev/null 2>&1; then
    echo "asdf already installed"
else
    brew install asdf
fi
