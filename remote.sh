#!/bin/bash

read -p "Project Name: " PROJECT_NAME
read -p "Enter GitHub Repository url: " GITHUB_URL
read -p "MySQL Database Username: " DB_USERNAME
read -s -p "Database Password: " DB_PASSWORD


mkdir -p "/home/$USER/scripts"

cd "/home/$USER/scripts"

git clone "$GITHUB_URL" "$PROJECT_NAME" || { echo "Faild to Clone Repository. Exiting"; exit 1; }

cd "$PROJECT_NAME"

composer install || { echo "Faild to Install Composer Dependencies. Exiting."; exit 1;}

cp .env.example .env

php artisan key:generate


sed -i "s/^DB_DATABASE=.*/DB_DATABASE=\"$PROJECT_NAME\"/" .env
sed -i "s/DB_USERNAME=.*/DB_USERNAME=$DB_USERNAME/" .env
sed -i "s/DB_PASSWORD=.*/DB_PASSWORD=\"$DB_PASSWORD\"/" .env


mysql -u "$DB_USERNAME" -p"$DB_PASSWORD" -e"create database if not exists $PROJECT_NAME;" || {echo "Faild to Create Mysql Database. Exiting."; exit 1;}

php artisan migrate --seed || { echo "Failed to Run Migrations. Exiting."; exit 1; }

# build assets (if needed)
# npm install
# npm run dev

chmod -R 775 storage
chmod -R 775 bootstrap/cache

echo "Your Laravel Project is Ready!"

php artisan serve
