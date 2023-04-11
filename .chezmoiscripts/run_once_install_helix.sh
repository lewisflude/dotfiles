#!/bin/sh
if  command -v hx >/dev/null 2>&1; then 
    echo "helix already installed"
else
    brew install helix
fi