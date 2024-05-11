#!/bin/bash

chmod +x ZeroDistroNoMain.sh

clear

echo "Recuerda usar la documentación para configuraciones especificas (wifi, particionamiento"

# Instalar paquetes esenciales ZD
pacstrap -K /mnt base base-devel linux-lts linux-firmware nano sudo networkmanager vim

clear

# Configuración del sistema
genfstab -U /mnt >> /mnt/etc/fstab

# Cambiar raiz al nuevo sistema (Ingresar al sistema)
echo "Presiona ENTER para continuar..."
read confirmacionParaCambiarRaiz

if [ confirmacionParaCambiarRaiz == ' ']
then
	arch-chroot /mnt
else
	arch-chroot /mnt
fi

# Zona horaria
ln -sf /usr/share/zoneinfo/America/Bogota /etc/localtime
cd
hwclock --systohc # Generación de archivo adjtime

# System Language

touch /etc/locale.gen
echo "System Language..."
echo "es_ES.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
touch /etc/locale.conf
echo "LANG=es_ES.UTF-8" >> /etc/locale.conf
touch /etc/vconsole.conf
echo "KEYMAP=es" >> /etc/vconsole.conf

clear

# Configurar Red (Hostname)

touch /etc/hostname
echo "Pc Hostname?"
read pchostname

echo $pchostname >> /etc/hostname

# Agregar hosts
cp -f hosts /etc/hosts

# Root PWD
echo "Root Password..."
passwd

sudo echo "root ALL=(ALL:ALL) ALL" >> /etc/sudoers
sudo echo -e "%wheel ALL=(ALL:ALL) ALL" >> /etc/sudoers
sudo echo -e "@includedir /etc/sudoers.d" >> /etc/sudoers

# Crear usuario

echo "Username?"
read usernameZD

useradd -mG wheel $usernameZD
passwd $usernameZD

clear

# Instalar GRUB
pacman -S grub os-prober efibootmgr

# UEFI or BIOS
echo "1) UEFI\n2) BIOS\n..."
read uefiorbios

if [ uefiorbios == 2]
then
	fdisk -l
	echo "En que disco desea instalar grub? Por ejemplo: /dev/sda"
	read disco
	grub-install --target=i386-pc /dev/$disco
else
	grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=grub
fi

grub-mkconfig -o /boot/grub/grub.cfg
exit

clear

# Desmontar particiones
umount -R /mnt

echo "EL EQUIPO SERÁ REINICIADO, ASEGURESE DE RETIRAR SU USB UNA VEZ SE APAGUE.\nUNA VEZ SE INICIE DE NUEVO, EJECUTE EL ARCHIVO ZeroDistroNoMain.sh"

reboot
