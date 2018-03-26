import random

from faker import Faker
from yaml import safe_dump

ROLES = ('admin', 'librarian', 'visitor')

fake = Faker()
users_k = 15
books_k = 30
reviews_k = 36
tags_k = 20
isbn = 123456789


def generate_users():
    users = {}
    users['admin'] = {
        'name': 'Admin',
        'surname': 'Admin',
        'email': 'admin@mail.ru',
        'password_digest': "<%= BCrypt::Password.create('admin') %>",
        'role': 'admin'
    }
    users['librarian'] = {
        'name': 'Librarian',
        'surname': 'Librarian',
        'email': 'librarian@mail.ru',
        'password_digest': "<%= BCrypt::Password.create('librarian') %>",
        'role': 'librarian'
    }
    users['visitor'] = {
        'name': 'Visitor',
        'surname': 'Visitor',
        'email': 'visitor@mail.ru',
        'password_digest': "<%= BCrypt::Password.create('visitor') %>",
        'role': 'visitor'
    }
    for i in range(users_k):
        role = random.choice(ROLES)
        users['user_%d' % i] = {
            'name': fake.first_name(),
            'surname': fake.last_name(),
            'email': fake.email(),
            'password_digest': "<%= BCrypt::Password.create('" + role + "') %>",
            'role': role
        }
    return users


def generate_books():
    books = {}
    for i in range(books_k):
        user_id = 'user_' + str(random.randint(0, users_k + 1))
        max_count = random.randint(1, 21)
        options = random.randint(0, 2)
        if options == 0:
            available_count = max_count
        elif options == 1:
            available_count = random.randint(1, max_count)
        else:
            available_count = 0
        books['book_%d' % i] = {
            'user': user_id,
            'isbn': str(isbn + i),
            'author': fake.name(),
            'year': fake.date(),
            'annotations': fake.text(),
            'max_count': max_count,
            'available_count': available_count,
            'publisher': fake.company(),
            # 'content': '/uploads/books/default/content.jpg',
            # 'cover': 'public/uploads/book/default/cover.jpg'
        }
    return books


def generate_reviews():
    reviews = {}
    for i in range(reviews_k):
        user_id = 'user_' + str(random.randint(0, users_k + 1))
        book_id = 'book_' + str(random.randint(0, books_k + 1))
        reviews['review_%d' % i] = {
            'user': user_id,
            'book': book_id,
            'comments': fake.text(),
            'mark': random.randint(1, 11),
        }
    return reviews


if __name__ == '__main__':
    users = generate_users()
    books = generate_books()
    reviews = generate_reviews()
    with open('users.yml', 'w+') as seeds:
        safe_dump(users, seeds, default_flow_style=False)
    with open('books.yml', 'w+') as seeds:
        safe_dump(books, seeds, default_flow_style=False)
    with open('reviews.yml', 'w+') as seeds:
        safe_dump(reviews, seeds, default_flow_style=False)
