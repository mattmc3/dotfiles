function abbr_bak --description 'Back up abbreviations'
    set abbrbak "$HOME"/.config/fish/_bak
    set abbrbak_file "$abbrbak"/abbr_(date +"%Y%m%d_%H%M%S").fish
    mkdir -p $abbrbak
    abbr -s >"$abbrbak_file"
    echo "Fish abbreviations backup created: $abbrbak"
end
