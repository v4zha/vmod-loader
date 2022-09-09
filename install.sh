printf "
██╗   ██╗███╗   ███╗ ██████╗ ██████╗
██║   ██║████╗ ████║██╔═══██╗██╔══██╗
██║   ██║██╔████╔██║██║   ██║██║  ██║
╚██╗ ██╔╝██║╚██╔╝██║██║   ██║██║  ██║
 ╚████╔╝ ██║ ╚═╝ ██║╚██████╔╝██████╔╝
  ╚═══╝  ╚═╝     ╚═╝ ╚═════╝ ╚═════╝

"

printf "Installing vmodLoader : \n"

printf "Getting Vmod : \n"

if [ -d "~/.local/bin" ]
then
    mkdir ~/.local/bin
fi

curl -L  https://github.com/v4zha/vmod-loader/releases/latest/download/vmod > ~/.local/bin/vmod
chmod +x ~/.local/bin/vmod

printf "Getting Vmod Default Config : \n"

if [ -d "~/.config/vmod" ]
then
    mkdir ~/.config/vmod
fi
curl -L  https://github.com/v4zha/vmod-loader/releases/latest/download/vmod.yml > ~/.config/vmod/vmod.yml
