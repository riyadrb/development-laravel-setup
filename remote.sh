#!/bin/bash

read -p "Project Name: " PROJECT_NAME
read -p "Enter GitHub Repository url: " GITHUB_URL
read -p "MySQL Database Username: " DB_USERNAME
read -s -p "Database Password: " DB_PASSWORD


mkdir -p "/home/$USER/scripts"

cd "/home/$USER/scripts"

git clone "$GITHUB_URL" "$PROJECT_NAME"

cd "$PROJECT_NAME"

composer install

cp .env.example .env

php artisan key:generate


sed -i "s/^DB_DATABASE=.*/DB_DATABASE=\"$PROJECT_NAME\"/" .env
sed -i "s/DB_USERNAME=.*/DB_USERNAME=$DB_USERNAME/" .env
sed -i "s/DB_PASSWORD=.*/DB_PASSWORD=\"$DB_PASSWORD\"/" .env


mysql -u "$DB_USERNAME" -p"$DB_PASSWORD" -e"create database if not exists $PROJECT_NAME;"

php artisan migrate --seed

# build assets (if needed)
# npm install
# npm run dev

chmod -R 775 storage
chmod -R 775 bootstrap/cache

echo "Your Laravel Project is Ready!"

php artisan serve
