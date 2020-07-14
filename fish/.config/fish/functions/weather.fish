function weather --description 'What is the weather?'
    curl http://wttr.in/"$$argv[1]"
end
