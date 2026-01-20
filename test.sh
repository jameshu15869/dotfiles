#!/usr/bin/env bash

# Open a temporary Docker container, run the install script, then enter base

docker build -t dotfiles-test -f Dockerfile.test . && docker run --rm -it dotfiles-test /bin/bash -c "./setup.sh -v; exec /bin/bash"
