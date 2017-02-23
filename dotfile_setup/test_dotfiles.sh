#!/bin/bash

#docker build -t devenv_test .
docker run -ti --rm \
	-v $(pwd)/setup_dotfiles.sh:/root/setup_dotfiles.sh \
    -w /root \
	devenv_test bash
