require 'faker'

# Users
User.create id: 1, name: 'admin name', surname: 'admin surname', email: 'admin@mail.ru', password: 'admin', role: 'admin'
User.create id: 2, name: 'visitor name', surname: 'visitor surname', email: 'visitor@mail.ru', password: 'visitor'
User.create id: 3, name: 'librarian name', surname: 'librarian surname', email: 'librarian@mail.ru', password: 'visitor', role: 'librarian'
ActiveRecord::Base.connection.execute('ALTER SEQUENCE users_id_seq RESTART WITH 4')

# Books
Book.create(title: 'Идиот', author: 'Ф. М. Достоевский', publisher: 'MGM')