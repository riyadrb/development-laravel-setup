#!/bin/bash


read -p "Project name: " PROJECT_NAME
read -p "MySQL Database Username: " DB_USERNAME
read -s -p "Database Password: " DB_PASSWORD

mkdir -p "/home/$USER/scripts"

cd "/home/$USER/scripts"

composer create-project --prefer-dist laravel/laravel "$PROJECT_NAME"

cp .env.example .env

php artisan key:generate


sed -i "s/^DB_DATABASE=.*/DB_DATABASE=\"$PROJECT_NAME\"/" .env
sed -i "s/DB_USERNAME=.*/DB_USERNAME=$DB_USERNAME/" .env
sed -i "s/DB_PASSWORD=.*/DB_PASSWORD=\"$DB_PASSWORD\"/" .env

mysql -u "$DB_USERNAME" -p"$DB_PASSWORD" -e"create database if not exists $PROJECT_NAME;"

php artisan migrate --seed

chmod -R 775 storage
chmod -R 775 bootstrap/cache

echo "Your Laravel Project is Ready!"

php artisan serve
