#!/bin/bash

chmod +x ZeroDistroNoMain.sh

clear

echo "Recuerda usar la documentación para configuraciones especificas (wifi, particionamiento)"
read

# Instalar paquetes esenciales ZD
pacstrap -K /mnt base base-devel linux-lts linux-firmware nano sudo networkmanager vim

clear

# Configuración del sistema
genfstab -U /mnt >> /mnt/etc/fstab

# Cambiar raiz al nuevo sistema (Ingresar al sistema)
echo "Presiona ENTER para continuar..."
read

arch-chroot /mnt
