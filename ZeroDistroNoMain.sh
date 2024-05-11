# Habilitar NetworkManager
sudo systemctl enable NetworkManager
sudo systemctl start NetworkManager

echo "Activar conexión..."
read confirmacion2
nmtui

# POST-INSTALACIÓN ZD
sudo pacman -S xorg-server xorg-apps xorg-xinit xf86-video-intel(intel) xf86-video-amdgpu(amd) xf86-video-nouveau(nvidia) bspwm sxhkd

sudo pacman -S ly

sudo systemctl enable ly.service

sudo pacman -S ttf-jetbrains-mono-nerd bash dmenu nitrogen fastfetch vlc picom xfce4-terminal xfce4-settings xfce4-session plank picom arandr polybar git brightnessctl pcmanfm firefox openssh unzip udisks2 scrot kolourpaint pipewire pipewire-pulse pavucontrol xdg-user-dirs btop libinput bluez bluez-utils blueman

xdg-user-dirs-update

touch .xprofile
mkdir /etc/WallZD
cp -r WallZD/mainwallpaperZD.png /etc/WallZD
echo -e "sxhkd &" >> .xprofile
echo -e "nitrogen /etc/WallZD/mainwallpaperZD.png" >> .xprofile
echo -e "nitrogen --restore &" >> .xprofile
echo -e "exec bspwm" >> .xprofile


mkdir .config
mkdir .config/bspwm
mkdir .config/sxhkd

cp -r bspwm/bspwmrc ~/.config/bspwm
cp -r sxhkd/sxhkdrc ~/.config/sxhkd
rm -rf .config/polybar
mv polybar ~/.config/

chmod +x ~/.config/bspwm/bspwmrc
chmod +x ~/.config/polybar/launch.sh

mkdir /etc/X11
mkdir /etc/X11/xorg.conf.d

cp -r 00-keyboard.conf /etc/X11/xorg.conf.d/

