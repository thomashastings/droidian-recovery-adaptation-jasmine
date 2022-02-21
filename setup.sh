# Droidian Adaptation for the Xiaomi Mi A2 (jasmine_sprout)
# Flashing based on: https://github.com/droidian-releng/android-recovery-flashing-template

# Contains fixes for:
# 1. Brightness
# 2. Bluetooth
# 3. Scaling

# https://droidian.org

OUTFD=/proc/self/fd/$1;
VENDOR_DEVICE_PROP=`grep ro.product.vendor.device /vendor/build.prop | cut -d "=" -f 2 | awk '{print tolower($0)}'`;

# ui_print <text>
ui_print() { echo -e "ui_print $1\nui_print" > $OUTFD; }

mkdir /r;

# mount droidian rootfs
mount /data/rootfs.img /r;

# Copy files
ui_print "Copying device adaptation files...";
cp -r data/* /r/;

# Do "chmod a+c /etc/rc.local" for first boot
chroot /r /bin/bash /local/bin/first-boot.sh

# Add boot slot switching to ~/.bashrc
echo 'alias switch-a="unset LD_PRELOAD; unset LD_LIBRARY_PATH; /system/bin/bootctl set-active-boot-slot 0"' >> /r/home/droidian/.bashrc
echo 'alias switch-b="unset LD_PRELOAD; unset LD_LIBRARY_PATH; /system/bin/bootctl set-active-boot-slot 1"' >> /r/home/droidian/.bashrc

# umount rootfs
umount /r;
