# MIT License
# 
# Copyright (c) 2025 Jean LELIEVRE
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

# How to use this script ?
#
# 1. ensure `~/.config/scw/config.yaml` file only contains the following information:
#     
#     ```
#     access_key: ...
#     secret_key: ...
#     default_organization_id: ...
#     default_project_id: ...
#     default_region: ...
#     default_zone: ...
#     ```
#
# 2. use `openssl enc -pbkdf2 -aes-256-cbc -salt -in ~/.config/scw/config.yaml -out ~/.config/scw/encrypted_config.yaml` to encrypt the plain text file;
# 3. move this script into your home folder and add the alias `alias scw="~/encrypt_decrypt_scw_config.sh" in `.zshrc`

#!/bin/zsh

OPENSSL_OUTPUT=$(openssl enc -pbkdf2 -aes-256-cbc -d -in ~/.config/scw/encrypted_config.yaml)

ACCESS_KEY=$(echo "$OPENSSL_OUTPUT" | grep access_key | sed 's/access_key: //')
SECRET_KEY=$(echo "$OPENSSL_OUTPUT" | grep secret_key | sed 's/secret_key: //')
DEFAULT_ORGANIZATION_ID=$(echo "$OPENSSL_OUTPUT" | grep default_organization_id | sed 's/default_organization_id: //')
DEFAULT_PROJECT_ID=$(echo "$OPENSSL_OUTPUT" | grep default_project_id | sed 's/default_project_id: //')
DEFAULT_REGION=$(echo "$OPENSSL_OUTPUT" | grep default_region | sed 's/default_region: //')
DEFAULT_ZONE=$(echo "$OPENSSL_OUTPUT" | grep default_zone | sed 's/default_zone: //')

SCW_ACCESS_KEY=$ACCESS_KEY \
    SCW_SECRET_KEY=$SECRET_KEY \
    SCW_DEFAULT_ORGANIZATION_ID=$DEFAULT_ORGANIZATION_ID \
    SCW_DEFAULT_PROJECT_ID=$DEFAULT_PROJECT_ID \
    SCW_DEFAULT_REGION=$DEFAULT_REGION \
    SCW_DEFAULT_ZONE=$DEFAULT_ZONE \
    /usr/local/bin/scw "$@"
