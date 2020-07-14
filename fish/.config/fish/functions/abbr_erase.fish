function abbr_erase --description 'Erase all abbr'
    if not read_confirm "This will erase all your abbreviations. You sure?"
        return 0
    end
    abbr_bak
    abbr -l | grep -E "$argv" | xargs -I"{}" fish -c 'abbr -e "{}"'
end
