FROM php:8.1-apache

# Copy app to web root
COPY . /var/www/html/

# Set correct permissions
RUN chown -R www-data:www-data /var/www/html

# Set correct document root for Yii2
RUN sed -i 's|DocumentRoot /var/www/html|DocumentRoot /var/www/html/web|g' /etc/apache2/sites-available/000-default.conf

# Enable Apache mod_rewrite (Yii2 uses pretty URLs)
RUN a2enmod rewrite

# Optional: update Apache config for URL rewriting
RUN sed -i '/<Directory \/var\/www\/>/,/<\/Directory>/ s/AllowOverride None/AllowOverride All/' /etc/apache2/apache2.conf

# Install PHP extensions
RUN docker-php-ext-install pdo pdo_mysql

