FROM php:8.2-fpm-alpine

# Install system dependencies
RUN apk add --no-cache \
    autoconf \
    bash \
    curl \
    g++ \
    gcc \
    git \
    icu-dev \
    icu-libs \
    libzip-dev \
    make \
    mysql-client \
    nodejs \
    npm \
    oniguruma-dev \
    openssh-client \
    postgresql-dev \
    rsync \
    zlib-dev

# Install PHP extensions
RUN docker-php-ext-install \
    bcmath \
    exif \
    intl \
    mysqli \
    opcache \
    pdo \
    pdo_mysql \
    zip

# Install and configure Redis extension
RUN pecl install redis && docker-php-ext-enable redis

# Install ImageMagick
RUN apk add --no-cache imagemagick imagemagick-dev \
    && pecl install imagick \
    && docker-php-ext-enable imagick

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Configure PHP
RUN echo "upload_max_filesize = 64M" > /usr/local/etc/php/conf.d/uploads.ini \
    && echo "post_max_size = 64M" >> /usr/local/etc/php/conf.d/uploads.ini \
    && echo "memory_limit = 256M" >> /usr/local/etc/php/conf.d/uploads.ini \
    && echo "max_execution_time = 300" >> /usr/local/etc/php/conf.d/uploads.ini \
    && echo "max_input_time = 300" >> /usr/local/etc/php/conf.d/uploads.ini

# Install Apache (for WordPress)
RUN apk add --no-cache apache2 apache2-proxy apache2-ssl \
    && mkdir -p /run/apache2

# Configure Apache
RUN sed -i 's#^DocumentRoot ".*#DocumentRoot "/var/www/html/web"#g' /etc/apache2/httpd.conf \
    && sed -i 's#AllowOverride [Nn]one#AllowOverride All#' /etc/apache2/httpd.conf \
    && sed -i 's#^ServerRoot .*#ServerRoot /var/www#g' /etc/apache2/httpd.conf \
    && sed -i 's/^#LoadModule\ rewrite_module/LoadModule\ rewrite_module/' /etc/apache2/httpd.conf \
    && sed -i 's/^#LoadModule\ deflate_module/LoadModule\ deflate_module/' /etc/apache2/httpd.conf \
    && sed -i 's/^#LoadModule\ expires_module/LoadModule\ expires_module/' /etc/apache2/httpd.conf

# Set working directory
WORKDIR /var/www/html

# Install Bedrock WordPress
RUN composer create-project roots/bedrock . --no-interaction

# Set permissions
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html

# Expose port
EXPOSE 80

# Start Apache
CMD ["httpd", "-D", "FOREGROUND"]
