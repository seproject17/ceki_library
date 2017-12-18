Библиотека ЦЭКИ
===============
Библиотека ЦЭКИ

**Version:** v1.0.0

## Summary
### Users

| URL  | Description |
| ---  | ----------- |
| [GET /users](#get-users)  | Find all users |
| [GET /users/{id}](#get-users) | Find one user with specific id |
| [POST /users](#get-users) | Create new user account |
| [PUT /users/{id}](#get-users) | Update user account |
| [DELETE /users/{id}](#get-users) | Delete user account |
| [POST /users/login](#get-users) | Login in system |
| [POST /users/{id}/change_username](#get-users) | Change username |
| [POST /users/{id}/change_password](#get-users) | Change password |

### Books

| URL  | Description |
| ---  | ----------- |
| [GET /books](#get-books)   | Find all books |
| [GET /books/{id}](#get-books)  | Find one book with specific id |
| [POST /books](#get-books) | Create new user book |
| [PUT /books/{id}](#get-books)  | Update book |
| [DELETE /books/{id}](#get-books)  | Delete book |
| [POST /books/{id}/file](#get-books) | Upload book file |
| [GET /books/{id}/file](#get-books) | Download book file |
| [DELETE /books/{id}/file](#get-books) | Delete book file |
| [POST /books/{id}/borrow](#get-books)  | Borrow book |
| [POST /books/{id}/return](#get-books)  | Return book |
| [GET /books/free](#get-books) | Find all books which have at least one free item |
| [GET /books/{id}/readers](#get-books) | Find all book readers |
| [GET /users/{id}/books/read](#get-books)  | Find all books read by specific user |
| [GET /users/{id}/books/borrowed](#get-books)  | Find all books borrowed by specific user |
| [GET /users/{id}/books/added](#get-books) | Find all books which added by specific user |

### Book Items

| URL  | Description |
| ---  | ----------- |
| GET /book_items  | Find all book items |
| GET /book_items/{id} | Find a book item with specific id |
| POST /book_items/book/{bookId} | Create new user book item |
| PUT /book_items/{id} | Update book item |
| DELETE /book_items/{id} | Delete book item |

### Reviews

| URL  | Description |
| ---  | ----------- |
| GET /reviews  | Find all reviews |
| GET /reviews/{id} | Find review with specific id |
| POST /reviews/book/{bookId} | Create new review |
| PUT /reviews/{id} | Update review |
| DELETE /reviews/{id} | Delete review |

## Detailed 
### Users

#### GET /users
---
**Summary:** Find all users

**Response body**
```json
[
  {
    "id": 1,
    "name": "Иван",
    "surname": "Иванов",
    "email": "ivan@mail.ru",
    "role": "admin"
  },
  {
    "id": 2,
    "name": "Мария",
    "surname": "Федорова",
    "email": "maria@mail.ru",
    "role": "librarian"
  },
  {
    "id": 3,
    "name": "Алексей",
    "surname": "Алексеевич",
    "email": "alex@mail.ru",
    "role": "visitor"
  }
]
```

**Response status**

| Code | Description |
| ---- | ----------- |
| 200 | Success |
| 401 | Unauthorized |

#### GET /users/{id}
---
**Summary:** Find one user with specific id

**Response body**
```json
{
  "id": 3,
  "name": "Алексей",
  "surname": "Алексеевич",
  "email": "alex@mail.ru",
  "role": "visitor"
}
```

**Response status**

| Code | Description |
| ---- | ----------- |
| 200 | Success |
| 401 | Unauthorized |

#### POST /users
---
**Summary:** Create new user account

**Request body**

```json
{
  "name": "Алексей",
  "surname": "Алексеевич",
  "email": "alex@mail.ru",
  "password": "veryverylongpassword",
  "role": "visitor"
}
```

**Response body**

```json
{
  "name": "Алексей",
  "surname": "Алексеевич",
  "email": "alex@mail.ru",
  "role": "visitor"
}
```

**Response status**

| Code | Description |
| ---- | ----------- |
| 201 | New user account created |
| 401 | Unauthorized |
| 403 | Forbidden |

#### PUT /users/{id}
---
**Summary:** Update user account

**Request body**

```json
{
  "name": "Алексей",
  "surname": "Алексеевич"
}
```

**Response body**

```json
{
  "name": "Алексей",
  "surname": "Алексеевич",
  "email": "alex@mail.ru",
  "role": "visitor"
}
```

**Responses**

| Code | Description |
| ---- | ----------- |
| 200 | Success |
| 401 | Unauthorized |
| 403 | Forbidden |

#### DELETE /users/{id}
---
**Summary:** Delete user account with specific id

**Responses**

| Code | Description |
| ---- | ----------- |
| 200 | Success |
| 401 | Unauthorized |
| 403 | Forbidden |

#### POST /users/login
---
**Summary:** Login in system

**Request body**
```json
{
  "email": "ivan@mail.ru",
  "password": "1234"
}
```

**Response body**
```json
{
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjQifQ.WI3T7vsaXPtHX1ReJZ6uh8Tg_2OuCoElY2DF5zBAnLo"
}
```
**Response status**

| Code | Description |
| ---- | ----------- |
| 200 | User was logged in |
| 404 | User was not found |

#### PUT /users/{id}/change_email
---
**Summary:** Change users email

**Request body**
```json
{
  "email": "ivan@mail.ru"
}
```

**Response status**

| Code | Description |
| ---- | ----------- |
| 200 | Success |
| 401 | Unauthorized |
| 403 | Forbidden |

#### PUT /users/{id}/change_password
---
**Summary:** Change users password

**Request body**
```json
{
  "password": "1234"
}
```

**Response status**

| Code | Description |
| ---- | ----------- |
| 200 | Success |
| 401 | Unauthorized |
| 403 | Forbidden |

### Books

#### GET /books
---
**Summary:** Find all books registered in library

**Response body**
```json
[
  {
    "isbn": 9783161484100,
    "title": "Machine Learning with Python Cookbook. Practical Solutions from Preprocessing to Deep Learning",
    "author": "Chris Albon",
    "publisher": "O'Reilly Media",
    "publisher_date": "2017",
    "annotations": "The Python programming language and its libraries, including pandas and scikit-learn, provide a  production-grade environment to help you accomplish a broad range of machine-learning tasks. With this comprehensive cookbook, data scientists and software engineers familiar with Python will benefit from almost 200 practical recipes for building a comprehensive machine-learning pipeline—everything from data preprocessing and feature engineering to model evaluation and deep learning",
    "tags": [
      "python",
      "machine learning",
      "deep learning"
    ]
  }
]
```
**Response status**

| Code | Description |
| ---- | ----------- |
| 200 | Success |
| 401 | Unauthorized |

