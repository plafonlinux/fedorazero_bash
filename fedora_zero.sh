#!/bin/bash

echo ""
echo "| Привет! Опять ставим систему заново? Ладно, дело ваше ... Давайте установим необходимый софт!"
echo ""
echo "---> Прежде чем начать, советую глянуть сюда: https://plafon.gitbook.io/fedora-zero/"
echo ""
echo "| Итак, приступимс милорд:"

#Обновление системы после установки:

echo ""
read -p ">>> Обновимся для начала? (y/n) " choice
echo ""
if [ "$choice" == "y" ]; then
sudo dnf upgrade --refresh --best --allowerasing -y
flatpak update -y
sudo dnf autoremove
sudo dnf clean all 
flatpak uninstall --unused -y 
echo ""
echo "| Отлично! Система обновилась, даже немного почистилась, теперь можно продолжить!"
else
echo "| Очень странное решение, но хозяин-барин!"
fi

# Добавление репозиториев:

echo ""
read -p ">>> Давайте добавим необходимые репозитории? (y/n) " choice
echo ""
if [ "$choice" == "y" ]; then
read -p ">>> Flathub нужен? (y/n) " choice
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
else
echo "| Пользоваться системой без ПО? Последний шанс ..."
fi
echo ""
read -p ">>> RPM Fusion нужен? (y/n) " choice
if [ "$choice" == "y" ]; then
echo ""
sudo dnf install http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
else
echo ""
echo "| Вы явно знаете, больше меня ... "
fi

#Установка нужного софта:

echo ""
read -p ">>> Давайте поставим необходимый набор ПО? (y/n) " choice
echo ""
if [ "$choice" == "y" ]; then

# Установка браузера
echo ""
read -p "Вам нужен браузер? (y/n) " answer
echo ""
if [ "$answer" == "y" ]; then
echo "Выберите офисные приложения для установки:"
echo ""
echo "1. Firefox"
echo "2. Yandex"
echo "3. Chrome"
echo ""
read -p "> " apps

if [ "$apps" == "1" ]; then
sudo dnf install firefox
else
echo ""
fi
elif [ "$apps" == "2" ]; then
cd ~/Загрузки/
wget -O yabro_lastest.rpm https://www.ocenaudio.com/start_download/ocenaudio_fedora35.rpm
wget -O yabro_lastest.rpm https://download.yandex.ru/downloadable_soft/browser/linux/yandex-browser-downloader.rpm
sudo dnf install oceanaudio_lastest.rpm
elif [ "$apps" == "3" ]; then
flatpak install --noninteractive -y flathub com.google.Chrome
fi
else
echo "Выбран неверный вариант"
fi

# Установка Телеграма
read -p ">>> Вам нужен Телеграм? (y/n) " choice
echo ""
if [ "$choice" == "y" ]; then
flatpak install flathub org.telegram.desktop
sudo flatpak override --env=XCURSOR_SIZE=12 org.telegram.desktop
flatpak --user override --filesystem=/home/$USER/.icons/:ro org.telegram.desktop
flatpak --user override --filesystem=/usr/share/icons/:ro org.telegram.desktop
echo ""
echo ">>> Telegram успешно установлен и настроен. Теперь можно заглянуть к нам: https://t.me/plafonyoutube"
else
echo "| Без проблем! Можно это сделать и потом ... Немного цифровой гигиены не помешает!"
fi

# Установка офисного пакета
echo ""
read -p "Вам нужен офис для работы с документами? (y/n) " answer
echo ""
if [ "$answer" == "y" ]; then
echo "Выберите офисные приложения для установки:"
echo ""
echo "1. LibreOffice"
echo "2. OnlyOffice"
echo "3. Установить все приложения"
echo ""
read -p "> " apps

if [ "$apps" == "1" ]; then
if rpm -q libreoffice 1>/dev/null; then
read -p "Локально установлен LibreOffice. Удалить его со всеми зависимостями? (y/n) " uninstall
if [ "$uninstall" == "y" ]; then
sudo dnf remove libreoffice*
else
echo ""
echo "Продолжаем установку дополнительно OnlyOffice"
echo ""
fi
else
flatpak install --noninteractive -y flathub org.libreoffice.LibreOffice
fi
elif [ "$apps" == "2" ]; then
flatpak install --noninteractive -y flathub org.onlyoffice.desktopeditors
elif [ "$apps" == "3" ]; then
if rpm -q libreoffice 1>/dev/null; then
sudo dnf remove libreoffice*
fi

flatpak install --noninteractive -y flathub org.libreoffice.LibreOffice
flatpak install --noninteractive -y flathub org.onlyoffice.desktopeditors
else
echo "Выбран неверный вариант"
fi
fi

# Установка торрент-клиента
echo ""
echo "| Такс! Ну, за торрент-клиент я полностью уверен! Позвольте мне эту дерзость!"
echo ""
flatpak install --noninteractive flathub com.transmissionbt.Transmission -y
echo ""
echo "| Клиент установлен без спроса! Мы готовы, капитан! Поднять паруса ... -_-"

# Установка набора для работы с графикой
echo ""
echo "Вам нужен набор для работы с графикой? (y/n)"
read answer
echo ""
if [ "$answer" == "y" ]; then
echo "Выберите, какие приложения вы хотите установить:"

echo "1) krita"
echo "2) inkscape"
echo "3) digikam"
echo "4) rawtherapee"
echo "5) identity"
echo "6) gimp"
echo "7) Установить всё"

read app_choice

if [ "$app_choice" -eq 7 ]; then
flatpak install --noninteractive -y flathub org.kde.krita org.inkscape.Inkscape org.kde.digikam com.rawtherapee.RawTherapee org.gimp.GIMP org.gnome.gitlab.YaLTeR.Identity
else
case "$app_choice" in
1)
flatpak install --noninteractive -y flathub org.kde.krita
;;
2)
flatpak install --noninteractive -y flathub org.inkscape.Inkscape
;;
3)
flatpak install --noninteractive -y flathub org.kde.digikam
;;
4)
flatpak install --noninteractive -y flathub com.rawtherapee.RawTherapee
;;
5)
flatpak install --noninteractive -y flathub org.gnome.gitlab.YaLTeR.Identity
;;
6)
flatpak install --noninteractive -y flathub org.gimp.GIMP
;;
*)
echo "Некорректный выбор"
;;
esac
fi

else
echo "Набор для работы с графикой не требуется"
fi

# Установка набора для видеомэйкера

echo ""
read -p "Хотите установить набор видеомэйкера? (y/n) " response
echo ""

if [[ "$response" =~ ^[Yy]$ ]]; then
echo "Выберите программу/программы, которые вы хотите установить:"
echo ""
echo "1. kdenlive"
echo "2. obsstudio"
echo "3. ocenaudio"
echo "4. Всё сразу!"
echo ""
read -p "Введите номер: " choice

# Install the selected program(s)
case "$choice" in
1)
flatpak install --noninteractive -y flathub org.kde.kdenlive
;;
2)
flatpak install --noninteractive -y flathub com.obsproject.Studio
cd ~/Загрузки/
wget -O droidcam_latest.zip https://files.dev47apps.net/linux/droidcam_1.8.2.zip
sudo dnf install unzip -y
unzip droidcam_latest.zip -d droidcam
cd droidcam && sudo ./install-client
;;
3)
cd ~/Загрузки/
sudo dnf install ocenaudio_fedora35.rpm
;;
4)
flatpak install --noninteractive -y flathub org.kde.kdenlive com.obsproject.Studio
cd ~/Загрузки/
sudo dnf install ocenaudio_fedora35.rpm
wget -O droidcam_latest.zip https://files.dev47apps.net/linux/droidcam_1.8.2.zip
sudo dnf install unzip -y
unzip droidcam_latest.zip -d droidcam
cd droidcam && sudo ./install-client
sudo dnf install libappindicator-gtk3
;;
*)
echo "Неизвестный выбор"
;;
esac
fi

# Установка набора для Игр
echo ""
echo "Вам нужен Steam/Proton/Wine для игр? (y/n)"
read answer
echo ""
if [ "$answer" == "y" ]; then
echo "Выберите, что именно вы хотите установить:"

echo "1) steam"
echo "2) wine"
echo "3) gamescope"
echo "4) protonup"
echo "5) mangohud"
echo "6) steamthinklauncher"
echo "7) Установить всё"

read app_choice

if [ "$app_choice" -eq 7 ]; then
sudo dnf install wine -y && flatpak install --noninteractive -y flathub com.valvesoftware.Steam com.valvesoftware.Steam.Utility.gamescope net.davidotek.pupgui2 org.freedesktop.Platform.VulkanLayer.MangoHud com.valvesoftware.Steam.Utility.steamtinkerlaunch
else
case "$app_choice" in
1)
flatpak install --noninteractive -y flathub com.valvesoftware.Steam
;;
2)
sudo dnf install wine -y
;;
3)
flatpak install --noninteractive -y flathub com.valvesoftware.Steam.Utility.gamescope
;;
4)
flatpak install --noninteractive -y flathub net.davidotek.pupgui2
;;
5)
flatpak install --noninteractive -y flathub org.freedesktop.Platform.VulkanLayer.MangoHud
;;
6)
flatpak install --noninteractive -y flathub com.valvesoftware.Steam.Utility.steamtinkerlaunch
;;
*)
echo "Некорректный выбор"
;;
esac
fi

# Установка библиотеки и читалки для книг
echo ""
read -p ">>> Хорошо, книги читаете? (y/n) " choice
echo ""
if [ "$choice" == "y" ]; then
flatpak install --noninteractive flathub com.calibre_ebook.calibre
flatpak install --noninteractive flathub com.github.johnfactotum.Foliate
echo ""
echo "| Библиотека готова!"
else
echo "| Без книг по жизни сложно .. ладно!"
fi

# Установка всякой всячины
echo ""
read -p "Хотите установить всякую всячину? (y/n) " response
echo "Консольные утилиты (neofetch, inxi, htop), плагины для Nautilus, иконки Papirus, Flatseal/Gnome Tweaks/Менеджер расширений и установка кодеков"
echo ""
if [[ "$response" =~ ^[Yy]$ ]]; then
echo ""
echo "Установка консольных утилит"
echo ""
sudo dnf install neofetch inxi htop -y
echo ""
echo "Установка дополнительных плагинов для Nautilus"
echo ""
sudo dnf install gnome-kra-ora-thumbnailer
echo ""
echo "Установка иконок Papirus"
echo ""
sudo dnf install papirus-icon-theme
cd /tmp
wget -qO- https://git.io/papirus-folders-install | sh
papirus-folders -C adwaita --theme Papirus-Dark
echo ""
echo "Установка Flatseal/Gnome Tweaks/Менеджер расширений"
flatpak install --noninteractive -y flathub com.github.tchx84.Flatseal
sudo dnf install gnome-tweaks
flatpak install --noninteractive -y flathub com.mattjakeman.ExtensionManager
echo ""
echo "Установка кодеков"
echo ""
flatpak install --noninteractive -y flathub io.mpv.Mpv
sudo dnf install gstreamer1-plugins-{bad-\*,good-\*,base} gstreamer1-plugin-openh264 gstreamer1-libav --exclude=gstreamer1-plugins-bad-free-devel -y
sudo dnf install lame\* --exclude=lame-devel -y
sudo dnf group upgrade --with-optional Multimedia -y
echo ""
echo "Со всякой всячиной покончено!"
echo ""
fi
fi

# Конец установки
echo "| Не забудь заглянуть к нам: https://t.me/plafonyoutube"
echo ""
read -p ">>> Мы закончили? (y/n) " choice
echo ""
if [ "$choice" == "y" ]; then
exit;
else
echo ""
read -p ">>> Ну закончили же! (y/n) " choice
fi

