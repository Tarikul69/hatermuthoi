# Use the official PHP 7.4 image as base
FROM php:7.4-fpm

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    zip \
    unzip \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libzip-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd pdo_mysql zip

# Set working directory
WORKDIR /var/www/html

# Copy composer.lock and composer.json
COPY composer.lock composer.json ./

# Install dependencies
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && composer install --no-autoloader --no-scripts

# Copy existing application directory contents
COPY . .

# Generate autoload files
RUN composer dump-autoload

# Set permissions
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html/storage

# Expose port 9000 and start php-fpm server
EXPOSE 9000
CMD ["php-fpm"]
