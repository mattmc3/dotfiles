function bright -d 'Make the screen bright'
    ensure-brew brightness
    brightness .8
end
