# name: Sorin
# author: Leonard Hecker <leonard@hecker.io>

# Sources:
# - Included with Fish: https://github.com/fish-shell/fish-shell/blob/master/share/tools/web_config/sample_prompts/sorin.fish
# - General theme setup: https://github.com/sorin-ionescu/prezto/blob/d275f316ffdd0bbd075afbff677c3e00791fba16/modules/prompt/functions/prompt_sorin_setup
# - Extraction of git info: https://github.com/sorin-ionescu/prezto/blob/d275f316ffdd0bbd075afbff677c3e00791fba16/modules/git/functions/git-info#L180-L441

function fish_prompt
    set -l cmd_status $status

    if test -n "$SSH_TTY"
        echo -n (set_color brred)"$USER"(set_color white)'@'(set_color yellow)(prompt_hostname)' '
    end

    echo -n (set_color blue)(prompt_pwd)' '

    set_color -o
    if test "$USER" = 'root'
        echo -n (set_color red)'# '
    end

    if test $cmd_status -ne 0
        echo -n (set_color white)'❯'(set_color cyan)'❯'(set_color magenta)'❯ '
    else
        echo -n (set_color red)'❯'(set_color yellow)'❯'(set_color green)'❯ '
    end
    set_color normal
end
