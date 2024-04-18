#!/bin/bash

# Comprobar si yt-dlp está instalado
if ! command -v yt-dlp &> /dev/null; then
    echo "yt-dlp no está instalado. Instalando..."
    # Instalar yt-dlp
    sudo wget https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp -O /usr/local/bin/yt-dlp
    sudo chmod a+rx /usr/local/bin/yt-dlp
    echo "yt-dlp instalado correctamente."
else
    echo "yt-dlp ya está instalado."
fi

# Comprobar si ffmpeg está instalado
if ! command -v ffmpeg &> /dev/null; then
    echo "ffmpeg no está instalado. Instalando..."
    # Instalar ffmpeg
    sudo apt install ffmpeg -y # Para sistemas basados en Debian/Ubuntu
    # Otros comandos de instalación para sistemas diferentes pueden ser necesarios aquí
    echo "ffmpeg instalado correctamente."
else
    echo "ffmpeg ya está instalado."
fi


# Solicitar la URL del video de YouTube
read -p "Introduce la URL del video de YouTube: " url

# Obtener información de los formatos disponibles
#echo "Obteniendo información de los formatos disponibles..."
#yt-dlp -F --get-filename "$url"

# Solicitar al usuario que seleccione el formato deseado
#read -p "Introduce el formato deseado: " format_number

# Descargar el video utilizando yt-dlp con el formato seleccionado
#echo "Descargando el video en el formato seleccionado..."
yt-dlp -f bestvideo+bestaudio --merge-output-format mp4 "$url"
#echo "Descarga completada."

# Obtener información de los formatos de audio disponibles
#echo "Obteniendo información de los formatos de audio disponibles..."
#ffmpeg -i "$url" -hide_banner 2>&1 | grep "Audio:"
#read -p "Selecciona un formato de audio: " formato
#echo "mp3"

# Extraer el audio del video utilizando ffmpeg
echo "Extrayendo el audio del video..."
ffmpeg -i *.mp4 -vn -acodec libmp3lame -q:a 2 audio_extraido.mp3
#Elimina el arrchivo de video
rm *.mp4
echo "Extracción completada."

