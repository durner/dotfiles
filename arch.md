# Arch Linux Installation Guide

## Preface

First install Windows, it is easier that way.


## Prepare Disks
Use this set-up, the first one is the efi boot partition, 2-4 partitions are windows related. We seperate boot from the remainder of the luks encrypted filesystem. In the following, an example setup for a 1 TB disk.
```
gdisk /dev/nvme0n1
```
```
Number  Size       Code  Name
   1   100.0 MiB   EF00  EFI system partition
   2   16.0 MiB    0C01  Microsoft reserved
   3   128.0 GiB   0700  Microsoft basic data (C)
   5   500.0 MiB   8300  Linux filesystem (boot)
   6   640.0 GiB   8309  Linux LUKS
   7   180.0 GiB   0700  Microsoft basic data (M)
```

## Setup Disks and Cryptsetup

### Setup the luks encrypted container

```
cryptsetup --type luks2 --cipher aes-xts-plain64 --hash sha512 --iter-time 5000 --key-size 512 --use-random luksFormat /dev/nvme0n1p6
```

### Open the container

```
cryptsetup open /dev/nvme0n1p6 main
```

### Physical and logical volumes

```
pvcreate /dev/mapper/main
vgcreate main /dev/mapper/main

lvcreate -L 64G main -n root
lvcreate -L 32G main -n home
lvcreate -l 100%FREE main -n data
```

### Ext4

```
mkfs.ext4 /dev/main/root
mkfs.ext4 /dev/main/home
mkfs.ext4 /dev/main/data
mkfs.ext4 /dev/nvme0n1p5
```

## Prepare Filesystem

### Mount

```
mount /dev/main/root /mnt
mkdir /mnt/home
mkdir /mnt/data
mkdir /mnt/boot
mount /dev/main/home /mnt/home
mount /dev/main/data /mnt/data
mount /dev/nvme0n1p5 /mnt/boot
mkdir /mnt/boot/efi
mount /dev/nvme0n1p1 /mnt/boot/efi
```

## Install

### Base

```
pacstrap /mnt base linux linux-firmware mkinitcpio lvm2 vi grub efibootmgr dhcpcd amd-ucode wpa_supplicant
```

Use intel-ucode for intel based machines

### Fstab

Think about noatime (trim will be handled later) and tmpfs for /tmp
```
genfstab -U /mnt >> /mnt/etc/fstab
```

### Chroot

```
arch-chroot /mnt
```

### Timezone

```
ln -sf /usr/share/zoneinfo/Europe/Berlin /etc/localtime
hwclock --systohc
```

### Locale

Uncomment languages at /etc/locale.gen
```
locale-gen
```

### Hostname

Update in /etc/hostname

### initramfs and hooks

Update the hooks in /etc/mkinitcpio.conf
```
HOOKS=(base udev autodetect modconf kms keyboard keymap consolefont block encrypt lvm2 filesystems fsck)
```

Create initramfs
```
mkinitcpio -p linux
```

### Grub

Update /etc/default/grub for encrypted disk (and pstate); use blkid for getting UUID of /dev/nvme0n1p6
```
GRUB_ENABLE_CRYPTODISK=y
GRUB_CMDLINE_LINUX_DEFAULT="amd_pstate=active"
GRUB_CMDLINE_LINUX="cryptdevice=UUID=:main root=/dev/main/root"
```

Install grub
```
grub-install --target=x86_64-efi --efi-directory=/boot/efi
grub-mkconfig -o /boot/grub/grub.cfg
chmod 700 /boot
```

### Root passwd

```
passwd
```

### Restart into arch

```
exit
reboot
```


## Post install

Set up internet connection

```
pacman -Syyu sudo acpid dbus avahi cups os-prober networkmanager neovim
```

Set up user
```
useradd -m -g users -s /bin/bash durner
passwd durner
gpasswd -a durner wheel
nvim /etc/sudoers
```

Enable systemctl services and trim
```
cryptsetup --allow-discards --persistent refresh main
systemctl enable --now fstrim.timer
systemctl enable avahi-daemon
systemctl enable acpid
systemctl enable cups.service
systemctl enable NetworkManager
```

Rebuild grub with os-prober
```
grub-mkconfig -o /boot/grub/grub.cfg
```

Install KDE
```
pacman -Syyu sddm plasma-meta plasma-wayland-session kde-system-meta kde-utilities-meta okular pipewire-pulse
systemctl enable sddm
```

Reboot and start with dotfiles
