# Проект "Офисная библиотека"
## ВАЖНО
Возможный стек технологий:
 1. Rails API 
 2. React + React Router + Redux (optional) на Node
 3. nginx
 4. PostgreSQL
 5. Хостим бек-сервер на ?
## Описание проекта
 Краткое описание проекта:
 Должно быть разработано веб-приложение, позволяющее вести учет использования общей офисной библиотеки. Сотрудники должны иметь возможность брать книги из библиотеки и добавлять в библиотеку свои книги. Минимально необходимый функционал:
* Оставление рецензий на книги
* Запрос рецензии у уже прочитавших
* Оставить запрос на книги, которые уже кто-то читает, о чем уведомлять читающего
* Внутренние рейтинги книг

 Серверная часть приложения должна быть реализована на Ruby on Rails.

## Заказчик
ФГБУ «ЦЭКИ» Контакное лицо: Бендюкова Оксана hr@ceki.ru

## Архитектура

### Стек технологий

 1. Ruby / RoR 5
 2. Capistrano 
 3. Puma
 4. React + React Router + Redux (optional)
 5. nginx
 6. OpenSSH
 7. Ubuntu 14.04 / 16.04
 8. Git
 9. PostgreSQL
 10. Redis (optional)
 
## Quick tutorial
 1. Склонируйте репу у себя и зайдите в папку
 ```bash
 git clone https://github.com/seproject17/ceki_library/
 cd ceki_library
 ```
 
 2. Установите brew (если у вас Mac)
 ```bash
 /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
 ```
 
 3. Обновите ruby 
 ```bash
 brew update
 brew install ruby-build
 brew install rbenv
 rbenv install 2.4.2
 rbenv global 2.4.2
 ```
 
 4. Установите rails
 ```bash
 gem install bundler
 gem install rails
 ```
 
 5. Установите postgresql
 ```bash
 brew install postgres
 ```
 
 6. Войдите в клиент postgresql
 ```bash
 psql postgres
 ```
 
 7. Создайте пользователя 
 ```sql
 CREATE USER ceki WITH password 'seproject17' CREATEDB LOGIN;
 ```
 
 8. Выйдите из клиента
 ```sql
 \q
 ```
 
 9. Установите все зависимости и запустите сервер
 ```bash
 bundle install
 rails s
 ```
 
 10. Наберите в браузере localhost:3000 и вы увидет веселую картинку, значит все OK
 11. Наберите в браузере localhost:3000/api_docs и вы увидете документацию к API

## Полезные ссылки
 1. [A Top Shelf Web Stack—Rails 5 API + ActiveAdmin + Create React App](https://medium.com/superhighfives/a-top-shelf-web-stack-rails-5-api-activeadmin-create-react-app-de5481b7ec0b) 
 2. [Build a RESTful JSON API With Rails 5 - Part One](https://scotch.io/tutorials/build-a-restful-json-api-with-rails-5-part-one)
 3. [Ruby on Rails Swagger](https://github.com/domaindrivendev/rswag)
 4. https://rubyplus.com/articles/4311-Securing-an-API-in-Rails-5-using-Token-Based-Authentication
 5. http://culttt.com/2016/01/20/implementing-roles-and-permissions-in-ruby-on-rails/
 6. http://www.mccartie.com/2016/11/03/token-based-api-authentication.html


