# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.destroy_all
User.create(name: 'John', surname: 'Smith', email: 'smith@mail.ru', password: '1234')
User.create(name: 'Mary', surname: 'Smith', email: 'mary@mail.ru', password: '5678')

Book.create(title: 'The Tenant', author: 'Roman Polanski', publisher: 'MGM')