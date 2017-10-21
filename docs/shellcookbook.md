# Tips / Cookbook

shell scripting tips and tricks b/c what if Google goes out of business???

## How to determine macOS
```
if [ "$(uname -s)" = "Darwin" ]; then
    OS="macOS"
else
    OS=$(uname -s)
fi
```

## How to benchmark zsh load time
[source](https://carlosbecker.com/posts/speeding-up-zsh/)

zsh:
`for i in $(seq 1 10); do /usr/bin/time zsh -i -c exit; done`

bash:
`for i in $(seq 1 10); do /usr/bin/time bash -i -c exit; done`
