#!/bin/sh
if  command -v rg >/dev/null 2>&1; then
    echo "ripgrep already installed"
else
    brew install ripgrep
fi
