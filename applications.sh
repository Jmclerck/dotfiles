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
    '1password (https://1password.com)'
    'Kaleidoscope (https://kaleidoscope.app)'
    'LaunchControl (https://soma-zone.com)'
    'Opal (https://opalcamera.com)'
    'Parallels Desktop (https://parallels.com)'
    'Rectangle (https://rectangleapp.com)'
    'Tower (https://git-tower.com/mac)'
    'Visual Studio Code (https://code.visualstudio.com)'
    'Vivid (https://getvivid.app)'
    'All'
    'Exit'
)
links=(
    'https://1password.com/downloads/mac/'
    'https://kaleidoscope.app/download'
    'https://opalcamera.com/opal-composer/download'
    'https://parallels.com/products/desktop/'
    'https://rectangleapp.com'
    'https://soma-zone.com/LaunchControl/'
    'https://git-tower.com/mac'
    'https://code.visualstudio.com'
    'https://getvivid.app'
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
    'Exit')
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
