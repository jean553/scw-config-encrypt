# Scaleway CLI config encryption

Simple script to decrypt [Scaleway CLI](https://github.com/scaleway/scaleway-cli) config file everytime a `scw` command is run.
It allows to only store an encrypted version of `~/.config/scw/config.yaml` locally.
On April 2025, Scaleway CLI does not provide any config file encryption option.

## Usage

Ensure `~/.config/scw/config.yaml` file only contains the following information:
 
```sh
access_key: ...
secret_key: ...
default_organization_id: ...
default_project_id: ...
default_region: ...
default_zone: ...
```

Use `openssl enc -pbkdf2 -aes-256-cbc -salt -in ~/.config/scw/config.yaml -out ~/.config/scw/encrypted_config.yaml` to encrypt the plain text file.

Move this script into your home folder and add the alias `alias scw="~/encrypt_decrypt_scw_config.sh" in `.zshrc`.
