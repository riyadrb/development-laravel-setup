#!/bin/bash


read -p "Project Name: " PROJECT_NAME
read -p "MySQL Username: " DB_USERNAME
read -s -p "Database Password: " DB_PASSWORD

mkdir -p "/home/$USER/$PROJECT_NAME"

cd "/home/$USER/$PROJECT_NAME"

composer create-project --prefer-dist laravel/laravel .

cp .env.example .env

php artisan key:generate


sed -i -e "s|^DB_DATABASE=.*|DB_DATABASE=\"$PROJECT_NAME\"|" \
       -e "s|^DB_USERNAME=.*|DB_USERNAME=$DB_USERNAME|" \
       -e "s|^DB_PASSWORD=.*|DB_PASSWORD=\"$DB_PASSWORD\"|" .env


mysql -u "$DB_USERNAME" -p"$DB_PASSWORD" -e"create database if not exists $PROJECT_NAME;"

php artisan migrate --seed

chmod -R 775 storage
chmod -R 775 bootstrap/cache

php artisan serve
