#!/bin/bash

# Sanity check
[ -f /etc/fedora-release ] || { error "This script if for Fedora"; exit 127; }

rm -rf /tmp/repo &>/dev/null
mkdir -p /tmp/repo
