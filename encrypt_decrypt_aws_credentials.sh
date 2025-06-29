# How to use this script ?
#
# 1. better use ramfs to store your plain text credentials file
#
#     ```sh
#     sudo mount -t ramfs ramfs /ramfs
#     sudo chown your_user:your_group /ramfs
#     ```
#
# 2. ensure `/ramfs/credentials` file only contains the following information:
#     
#     ```
#     [profile]
#     aws_access_key_id: ...
#     aws_secret_access_key: ...
#     ```
#
# 3. use `openssl enc -pbkdf2 -aes-256-cbc -salt -in /ramfs/credentials_plain_text -out ~/.aws/credentials` to encrypt the plain text file;
# 4. move this script into your home folder and add the alias `alias scw="~/encrypt_decrypt_aws_credentials.sh" in `.zshrc`

openssl enc -pbkdf2 -aes-256-cbc -d -in ~/.aws/credentials -out /ramfs/aws_credentials_plain_text
AWS_SHARED_CREDENTIALS_FILE=/ramfs/aws_credentials_plain_text /usr/local/bin/aws "$@"
rm /ramfs/aws_credentials_plain_text
