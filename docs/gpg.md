# GPG

## Generate key

`gpg --gen-key`
`gpg --full-generate-key`

## Export Key
`gpg --armor --export C9DFE8043C26890E183267A4328CF67E1034F4FF`

## Encrypt File
`gpg --recipient "$PERS_EMAIL" --recipient "$WORK_EMAIL" --output myfile.txt.pgp --armor=ascii --encrypt myfile.txt`
