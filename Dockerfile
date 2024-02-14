FROM debian:bullseye-slim

WORKDIR /usr/src
  
# Instalar dependencias
RUN apt-get update && \
    apt-get install -y wget make gcc apache2 php libapache2-mod-php

# Copiar el código para la carga de archivos en apache
COPY UPLOAD/upload.php /var/www/html
COPY UPLOAD/upload.html /var/www/html/index.html

# Copiar el código fuente de vsftpd
COPY vsftpd-2.3.4 /usr/src/vsftpd-2.3.4

# Compilar e instalar vsftpd
RUN cd /usr/src/vsftpd-2.3.4 && \
    make && \
    mkdir -p /usr/local/man/man8 /usr/local/man/man5 && \
    make install

# Copiar el archivo de configuración
COPY vsftpd.conf /etc/vsftpd.conf

# Limpiar paquetes y archivos innecesarios
RUN apt-get purge -y wget make gcc && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/*

RUN chown -R www-data:www-data /var/www/html/
RUN chmod -R 755 /var/www/html/

RUN mkdir /var/lib/ftp
RUN mkdir /usr/share/empty

# Crea el archivo /etc/vsftpd.chroot_list
RUN touch /etc/vsftpd.chroot_list
EXPOSE 21/tcp

# usuarios y contraseñas
RUN useradd -m -d /home/ftpuser -s /bin/bash ftpuser && \
    echo "ftpuser:admin123" | chpasswd && \
    useradd -m -d /home/ftp -s /bin/bash ftp && \
    passwd -d ftp && \
    chmod a-w /home/ftp

#creacion y permisos del directorio 
RUN mkdir /var/www/html/uploads uploads
RUN chown www-data:www-data /var/www/html/uploads
RUN chmod 777 /var/www/html/uploads

COPY main.sh /

ENTRYPOINT ["/main.sh"]
CMD ["default"]









