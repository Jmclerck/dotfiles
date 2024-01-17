choice() {
    local choice=$1
    if [[ ${selections[choice]} ]]; then
        selections[choice]=
    else
        selections[choice]=+
    fi
}

PS3='Install applications: '
apps=(
    '1password'
    'Kaleidoscope'
    'Opal'
    'Parallels Desktop'
    'Rectangle'
    'Tower'
    'Visual Studio Code'
    'Vivid'
    'All'
    'None'
)
links=(
    'https://1password.com/downloads/mac/'
    'https://kaleidoscope.app/download'
    'https://opalcamera.com/opal-composer/download'
    'https://www.parallels.com/products/desktop/'
    'https://www.rectangleapp.com'
    'https://www.git-tower.com/mac'
    'https://code.visualstudio.com'
    'https://www.getvivid.app'
)

select app in "${apps[@]}"; do
    case $app in
    'All')
        i=0
        while [ $((i += 1)) -lt $((${#apps[@]} - 1)) ]; do
            choice i
        done
        break
        ;;
    'None')
        break
        ;;
    *)
        choice $REPLY
        ;;
    esac
done

for selection in "${!selections[@]}"; do
    if [[ ${selections[selection]} ]]; then
        open "${links[${selection} - 1]}"
    fi
done
