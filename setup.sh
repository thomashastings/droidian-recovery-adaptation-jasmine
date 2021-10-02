#!/bin/bash

echo "Updating system..."

sudo apt update && sudo apt dist-upgrade -y

echo "Downloading fixes..."

sudo mkdir /lib/systemd/system/bluebinder.service.d/

sudo wget https://raw.githubusercontent.com/Droidian-Mi-A2-6X/jasmine-tweaks/master/lib/systemd/system/bluebinder.service.d/90-jasmine.conf -O /lib/systemd/system/bluebinder.service.d/90-jasmine.conf && sudo chmod 0644 /lib/systemd/bluebinder.service.d/90-jasmine.conf

sudo wget https://raw.githubusercontent.com/Droidian-Mi-A2-6X/jasmine-tweaks/master/lib/systemd/system/brightness-fix.service -O /lib/systemd/system/brightness-fix.service && sudo chmod 0644 /lib/systemd/system/brightness-fix.service

sudo systemctl daemon-reload && sudo systemctl enable bluebinder.service && sudo systemctl enable brightness-fix.service && sudo systemctl start brightness-fix.service

sudo rm /usr/share/phosh/phoc.ini && sudo wget https://github.com/Droidian-Mi-A2-6X/jasmine-tweaks/raw/master/usr/share/phosh/phoc.ini -O /usr/share/phosh/phoc.ini && sudo chmod 0644 /usr/share/phosh/phoc.ini

echo "Setting up flatpak repo(s) for convenience..."

flatpak remote-add --user --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo && flatpak remote-add --user --if-not-exists kdeapps http://distribute.kde.org/kdeapps.flatpakrepo

echo "Rebooting now."

sudo systemctl reboot
