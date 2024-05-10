FROM php:8.0-apache

# Update package lists and install dependencies
RUN apt-get update -y \
    && apt-get install -y --no-install-recommends \
        openssl \
        zip \
        unzip \
        git \
        libonig-dev \
        default-mysql-client \
    && rm -rf /var/lib/apt/lists/*

# Install Composer globally
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install PHP extensions
RUN docker-php-ext-install pdo pdo_mysql mbstring

# Set the working directory
WORKDIR /var/www/html

# Copy composer.json file
COPY ./src/composer.json ./

# Copy the rest of the application code
COPY ./src ./

# Expose port 80
EXPOSE 80

# Start Apache server

CMD ["apache2-foreground"]



