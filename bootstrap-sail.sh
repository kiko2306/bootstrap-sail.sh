#!/bin/sh

# Installs Laravel Sail into an existing project

# The official Laravel Sail docs[1] provide instructions for installing Sail
# into an existing PHP application. But the official method requires invoking
# Composer locally. Part of Sail's appeal is that it removes the need to
# install PHP on your host machine. 

# This script is lifted from laravel.build[2], and thus uses the same method
# to bootstrap Sail into your app--namely, it creates a disposable Docker
# container, then within that container it installs all Composer
# dependencies, adds Laravel Sail to the list of dev dependencies, and
# invokes Sail's artisan command to publish the default docker-compose.yml.

# [1](https://laravel.com/docs/8.x/sail#installing-sail-into-existing-applications)
# [2](https://laravel.build/example-app)

docker run --rm \
    -v $(pwd):/opt \
    -w /opt laravelsail/php80-composer:latest \
    bash -c "composer require --dev laravel/sail && composer install && php artisan sail:install --with=mariadb,mailhog,redis"