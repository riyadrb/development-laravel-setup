#!/bin/bash


# User input
read -p "Enter the project name: " PROJECT_NAME
#read -p "Enter the database name: " db_database
read -p "Enter the MySQL database username: " DB_USERNAME
read -s -p "Enter the MySQL database password: " DB_PASSWORD


composer create-project --prefer-dist laravel/laravel "$PROJECT_NAME"

cd "/home/$USER/scripts/$PROJECT_NAME"

cp .env.example .env

php artisan key:generate


# Configure database settings in .env
sed -i "s/DB_DATABASE=laravel/DB_DATABASE=$PROJECT_NAME/" .env
sed -i "s/DB_USERNAME=''/DB_USERNAME=$DB_USERNAME/" .env
sed -i "s/DB_PASSWORD=/DB_PASSWORD=$DB_PASSWORD/" .env

mysql -u "$DB_USERNAME" -p"$DB_PASSWORD" -e"create database if not exists $PROJECT_NAME;"

php artisan migrate --seed

chmod -R 775 storage
chmod -R 775 bootstrap/cache

echo "Your Laravel Project is Ready!"

php artisan serve
