require 'faker'

RESOURCES_ROOT = File.join(File.expand_path('.', File.dirname(__FILE__)), 'resources')
AVATAR_PATH = File.join(RESOURCES_ROOT, 'avatar.jpg')
BASE64_IMG_REGEX = /data:(image\/gif|image\/jpeg|image\/png);base64,([a-zA-Z0-9+\/]+)=/i

IMG2MIME = {
    :gif => 'image/gif',
    :jpeg => 'image/jpeg',
    :png => 'image/png',
    :jpg => 'image/jpg'
}

def file2base64(file_path)
  img_type = file_path.split('.').last.to_sym
  f = File.open(file_path, 'r')
  base64_content = Base64.strict_encode64(f.read)
  "data:#{IMG2MIME[img_type]};base64,#{base64_content}="
end

# Users
User.create id: 1, name: 'admin name', surname: 'admin surname', email: 'admin@mail.ru', password: 'admin', role: 'admin', avatar: file2base64(AVATAR_PATH)
User.create id: 2, name: 'visitor name', surname: 'visitor surname', email: 'visitor@mail.ru', password: 'visitor', role: 'visitor'
User.create id: 3, name: 'librarian name', surname: 'librarian surname', email: 'librarian@mail.ru', password: 'librarian', role: 'librarian'
ActiveRecord::Base.connection.execute('ALTER SEQUENCE users_id_seq RESTART WITH 4')

# Books
book = Book.new id: 1, title: 'Идиот', author: 'Ф. М. Достоевский', publisher: 'MGM', max_count: 3
user = User.find(1)
user.books << book
user.save

book = Book.new id: 2, title: 'Шушкевич', author: 'Ф. М. КЕку', publisher: 'MGM', max_count: 7
user = User.find(2)
user.books << book
user.save

book = Book.new id: 3, title: 'Димасик', author: 'Романчик', publisher: 'MGM', max_count: 10
user = User.find(3)
user.books << book
user.save

ActiveRecord::Base.connection.execute('ALTER SEQUENCE books_id_seq RESTART WITH 4')

# # Reviews
# review = Review.new id: 1, mark: 5, comments: 'Cool'
# review.user = User.find(1)
# review.book = Book.find(1)
# review.save
#
# review = Review.new id: 2, mark: 3, comments: 'So so'
# review.user = User.find(1)
# review.book = Book.find(2)
# review.save
#
# review = Review.new id: 3, mark: 2, comments: 'Badly'
# review.user = User.find(2)
# review.book = Book.find(1)
# review.save
#
# review = Review.new id: 4, mark: 5, comments: 'Very good!'
# review.user = User.find(3)
# review.book = Book.find(3)
# review.save
#
# ActiveRecord::Base.connection.execute('ALTER SEQUENCE books_id_seq RESTART WITH 5')
#
# # Borrowings
# borrowing = Borrowing.new id: 1, borrow_date: Date(2017, 1, 1), return_date: Date(2017, 1, 2), status: :borrowed
# borrowing.user = User.find(1)
# borrowing.book = Book.find(1)
# borrowing.save
#
# borrowing = Borrowing.new id: 2, borrow_date: Date(2017, 1, 1), return_date: Date(2017, 1, 2), status: :borrowed
# borrowing.user = User.find(1)
# borrowing.book = Book.find(2)
# borrowing.save
# ActiveRecord::Base.connection.execute('ALTER SEQUENCE borrowings_id_seq RESTART WITH 3')