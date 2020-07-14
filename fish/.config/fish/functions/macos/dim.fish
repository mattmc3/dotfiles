function dim -d 'Dim the screen'
    if not type -q brightness
        brew install brightness
    end
    brightness .2
end
