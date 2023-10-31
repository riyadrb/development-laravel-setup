#!/bin/bash

read -p "Enter the project name: " PROJECT_NAME
read -p "Enter the MySQL database username: " DB_USERNAME
read -s -p "Enter the MySQL database password: " DB_PASSWORD


git clone https://github.com/DEVITD/ess.git ./"$PROJECT_NAME"

cd "/home/$USER/scripts/$PROJECT_NAME"

composer install

cp .env.example .env

php artisan key:generate


sed -i "s/DB_DATABASE=ess/DB_DATABASE=$PROJECT_NAME/" .env
sed -i "s/DB_USERNAME=''/DB_USERNAME=$DB_USERNAME/" .env
sed -i "s/DB_PASSWORD=/DB_PASSWORD=$DB_PASSWORD/" .env


mysql -u "$DB_USERNAME" -p"$DB_PASSWORD" -e"create database if not exists $PROJECT_NAME;"

php artisan migrate --seed

# build assets (if needed)
# npm install
# npm run dev

chmod -R 775 storage
chmod -R 775 bootstrap/cache

echo "Your Laravel Project is Ready!"

php artisan serve
