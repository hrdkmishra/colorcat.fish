#!/usr/bin/fish

function is_valid_color
    set word $argv[1]
    if string match -rq "^[^A-Fa-f0-9]*#?([A-Fa-f0-9]{6})[^A-Fa-f0-9]$argv" $word
        return 0
    else
        return 1
    end
end

function add_icon_and_hex
    set icon (echo -n " 󰨓")
    set hex (string replace --regex '.*#([A-Fa-f0-9]{6}).*' '$1' $argv[1])
    set_color $hex;echo -n $icon;set_color normal
end

if test (count $argv) -eq 1
    if not test -e $argv[1]
        echo $argv[1]
    else
        cat $argv[1]
    end
else
    cat $argv
end | while read -l line
    for word in $line
        if is_valid_color $word
            set_color $word
        end
        echo -n " $word"
    end
    add_icon_and_hex $line
    echo
end
