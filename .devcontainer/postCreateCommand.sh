#!/bin/bash

# install oh-my-zsh
wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O - | zsh || true

# set Van Oord pypi as default
export UV_INDEX=https://$PIP_ACCESS_TOKEN@pkgs.dev.azure.com/VanOord-IT/VanOord_Artifacts/_packaging/VanOord_Artifacts/pypi/simple/

uv sync

