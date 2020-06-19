FROM master4web/fpm74
# Maintainer
MAINTAINER Andrey Delfin <masterforweb@hotmail.com>

# Environments
ENV TIMEZONE Europe/Moscow
ENV PHP_MEMORY_LIMIT 1024M
ENV MAX_UPLOAD 128M
ENV PHP_MAX_FILE_UPLOAD 128
ENV PHP_MAX_POST 128M
ENV PHP_INI_FILE php.ini-production
ENV FPM_INI_FILE /usr/local/etc/php-fpm.d/www.conf
ENV WWW_USER 1000

RUN deluser www-data \
&& addgroup -g ${WWW_USER} -S www-data \
&& adduser -u ${WWW_USER} -D -S -G www-data www-data \
# fpm/conf.d/www.conf
&& sed -i "s|;*php_admin_value[error_log] =.*|php_admin_value[error_log] = /var/log/fpm-php.www.log|i" ${FPM_INI_FILE} \
#php.ini: usr/local/etc/php/php.ini
&& sed -i "s|;*date.timezone =.*|date.timezone = ${TIMEZONE}|i" ${PHP_INI_DIR}/php.ini \
&& sed -i "s|;*memory_limit =.*|memory_limit = ${PHP_MEMORY_LIMIT}|i" ${PHP_INI_DIR}/php.ini \
&& sed -i "s|;*upload_max_filesize =.*|upload_max_filesize = ${MAX_UPLOAD}|i" ${PHP_INI_DIR}/php.ini \
&& sed -i "s|;*max_file_uploads =.*|max_file_uploads = ${PHP_MAX_FILE_UPLOAD}|i" ${PHP_INI_DIR}/php.ini \
&& sed -i "s|;*post_max_size =.*|post_max_size = ${PHP_MAX_POST}|i" ${PHP_INI_DIR}/php.ini 
# user www
WORKDIR /vhosts
USER www-data