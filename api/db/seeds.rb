require 'faker'

# Users
User.create id: 1, name: 'admin name', surname: 'admin surname', email: 'admin@mail.ru', password: 'admin', role: 'admin'
User.create id: 2, name: 'visitor name', surname: 'visitor surname', email: 'visitor@mail.ru', password: 'visitor', role: 'visitor'
User.create id: 3, name: 'librarian name', surname: 'librarian surname', email: 'librarian@mail.ru', password: 'visitor', role: 'librarian'
ActiveRecord::Base.connection.execute('ALTER SEQUENCE users_id_seq RESTART WITH 4')

# Books
Book.create id: 1, title: 'Идиот', author: 'Ф. М. Достоевский', publisher: 'MGM', max_count: 3, user: User.find(1)
Book.create id: 2, title: 'Шушкевич', author: 'Ф. М. КЕку', publisher: 'MGM', max_count: 7,  user: User.find(2)
Book.create id: 3, title: 'Димасик', author: 'Романчик', publisher: 'MGM', max_count: 10,  user: User.find(3)
ActiveRecord::Base.connection.execute('ALTER SEQUENCE books_id_seq RESTART WITH 4')

# Reviews
review = Review.new id: 1, mark: 5, comments: 'Cool'
review.user = User.find(1)
review.book = Book.find(1)
review.save

review = Review.new id: 2, mark: 3, comments: 'So so'
review.user = User.find(1)
review.book = Book.find(2)
review.save

review = Review.new id: 3, mark: 2, comments: 'Badly'
review.user = User.find(2)
review.book = Book.find(1)
review.save

review = Review.new id: 4, mark: 5, comments: 'Very good!'
review.user = User.find(3)
review.book = Book.find(3)
review.save

ActiveRecord::Base.connection.execute('ALTER SEQUENCE books_id_seq RESTART WITH 5')

# Borrowings
borrowing = Borrowing.new id: 1, borrow_date: Date(2017, 1, 1), return_date: Date(2017, 1, 2), status: :borrowed
borrowing.user = User.find(1)
borrowing.book = Book.find(1)
borrowing.save

borrowing = Borrowing.new id: 2, borrow_date: Date(2017, 1, 1), return_date: Date(2017, 1, 2), status: :borrowed
borrowing.user = User.find(1)
borrowing.book = Book.find(2)
borrowing.save
ActiveRecord::Base.connection.execute('ALTER SEQUENCE borrowings_id_seq RESTART WITH 3')