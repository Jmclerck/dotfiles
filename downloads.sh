while true; do
    read -p "Install Applications? " yn
    case $yn in
        [Yy]* ) 
            open https://1password.com/downloads/mac/
            open https://code.visualstudio.com
            open https://kaleidoscope.app/download
            open https://store.serif.com/get/universal-licence-2/trial/
            open https://www.getvivid.app
            open https://www.git-tower.com/mac
            open https://www.parallels.com/products/desktop/
            open https://www.rectangleapp.com
            break;;
        [Nn]* ) 
            break;;
        [Ll]* )
            echo "1password, Visual Studio, Kaleidoscope, Affinity Designer, Vivid, Tower Parallels Desktop, Rectangle";;
        * ) 
            echo "Please answer yes or no.";;
    esac
done

while true; do
    read -p "Install development tools? " yn
    case $yn in
        [Yy]* ) 
            open https://github.com/mklement0/n-install; 
            open https://docs.deno.com/runtime/manual/getting_started/installation;
            open https://developer.1password.com/docs/cli/get-started/#step-1-install-1password-cli;
            break;;
        [Nn]* )
            break;;
        [Ll]* )
            echo "n-install, deno, 1password CLI";;
        * ) 
            echo "Please answer yes or no.";;
    esac
done
