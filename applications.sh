choice() {
    local choice=$1
    if [[ ${selections[choice]} ]]; then # toggle
        selections[choice]=
    else
        selections[choice]=+
    fi
}

PS3='Install applications: '
apps=(
    '1password'
    'Affinity Designer'
    'Kaleidoscope'
    'Parallels Desktop'
    'Rectangle'
    'Tower'
    'Visual Studio Code'
    'Vivid'
    'All'
    'Quit'
)
links=(
    'https://1password.com/downloads/mac/'
    'https://store.serif.com/get/universal-licence-2/trial/'
    'https://kaleidoscope.app/download'
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
    'Quit')
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
