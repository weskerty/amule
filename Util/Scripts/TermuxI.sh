#!/data/data/com.termux/files/usr/bin/bash
set -e

echo "Concede el Permiso para Evitar que el sistema Cierre la App"
sleep 5 
termux-wake-lock

echo "Concede permiso al almacenamiento"
sleep 5
printf 'y\y' | termux-setup-storage

echo "Actualizando, Tardara unos Minutos"
pkg install -y tur-repo x11-repo
apt-get update
apt update -y && yes | apt upgrade && pkg install -y proot-distro git wget termux-services termux-api msedit




proot-distro list | grep -q debian || proot-distro install debian

cat > ~/.bashrc <<'EOF'
termux-wake-lock

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${YELLOW}Presiona una Tecla para Evitar el Inicio Automatico...${NC}"

timeout=5

while [ $timeout -gt 0 ]; do
    echo -ne "${YELLOW}Iniciando en $timeout segundos...\r${NC}"

    if read -t 1 -n 1 keypress; then
        echo -e "\n${RED}Inicio Automatico Cancelado.${NC}"

        echo -e "${GREEN}Puedes Utilizar Termux Normalmente.${NC}"
        echo -e "El bot esta en un Contenedor, Utiliza el Comando ${YELLOW}proot-distro login debian${NC} para Ingresar."
        echo -e "${GREEN}Comandos Utiles:${NC}"
        echo -e "${YELLOW}ls${NC} Visor de Archivos. ${YELLOW}cd${NC} Navegador de Archivos. ${YELLOW}msedit${NC} Creador y Editor de Texto. ${YELLOW}mkdir${NC} Creador de Carpetas/Directorios ${YELLOW}rm${NC} Borrar Archivos. Cada uno de estos Comandos se puede usar junto con ${YELLOW}--help para ver sus Funciones"
        echo -e "${GREEN}Ejemplo:${NC}"
        echo -e "Ir a la Carpeta del bot: ${YELLOW}cd levanter${NC}"
        echo -e "Editar la Configuracion de Levanter: ${YELLOW}msedit config.env${NC} con Ctrl+O Guardas, Enter y Ctrl+X Salir de msedit."
        echo -e "${GREEN} ¿Necesitas Ayuda? Contacta con Nosotros en Telegram @LevanterLyfe ${NC}"

        echo -e "${RED} English ${NC}"
        echo -e "\n${RED}Autostart Canceled.${NC}"
        echo -e "${GREEN}You can use Termux normally.${NC}"
        echo -e "The bot is in a container, use the command ${YELLOW}proot-distro login debian${NC} to log in."
        echo -e "${GREEN}Useful Commands:${NC}"
        echo -e "${YELLOW}ls${NC} File Viewer. ${YELLOW}cd${NC} File Browser. ${YELLOW}msedit${NC} Text Creator and Editor. ${YELLOW}mkdir${NC} Folder/Directory Creator ${YELLOW}rm${NC} Delete Files. Each of these commands can be used in conjunction with ${YELLOW}--help to see their Functions"
        echo -e "${GREEN}Example:${NC}"
        echo -e "Go to Bot Folder: ${YELLOW}cd levanter${NC}"
        echo -e "Editing the Levanter Configuration: ${YELLOW}msedit config.env${NC} with Ctrl+O Save, Enter and Ctrl+X Exit msedit."
        echo -e "${GREEN} Need Help? Contact Us on GitHub ${NC}"

    
    fi

    timeout=$((timeout - 1))
done

echo -e "\n${GREEN}Iniciando aMuleD...${NC}"
proot-distro login debian -- bash -c 'cd repo 2>/dev/null || true && chmod +x START.sh && (sleep 20 && /data/data/com.termux/files/usr/bin/termux-open http://localhost:8000) && ./START.sh'


EOF

proot-distro login debian -- bash -c '
set -e

apt-get update
apt-get install -y git wget ffmpeg nodejs nano

echo "[D] Repo MuLy"
rm -rf aMuleD.bin
git clone https://github.com/weskerty/aMuleD.bin.git repo

echo "[D] "

mkdir -p /sdcard/Download/aMule

echo "[D] Descargas estaran en tu Carpeta Descargas."
ln -sfn /sdcard/Download/aMule repo/MuLy/Archivos

echo "[D] Actualizando"
cd repo
#cp -r .aMule ~/.aMule
chmod +x START.sh
./START.sh &
sleep 20
echo "[D] Iniciando" 
 /data/data/com.termux/files/usr/bin/termux-open "localhost:8000"
'

