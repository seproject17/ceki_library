Библиотека ЦЭКИ
===============
Библиотека ЦЭКИ

**Version:** v1.0.0

**Auth Type:** JWT Token Auth in Cookie 

**Hint**: :warning: means that this method is not implemented yet

## Summary
### Users

| URL  | Description |
| ---  | ----------- |
| [GET /users](#get-users)  | Find all users |
| [GET /users/{id}](#get-users) | Find one user with specific id |
| [GET /users/current](#get-users) | Get current user |
| [POST /users](#get-users) | Create new user account |
| [PUT /users/{id}](#get-users) | Update user account |
| [DELETE /users/{id}](#get-users) | Delete user account |
| [POST /users/login](#get-users) | Login in system |
| [POST /users/logout](#get-users) | Logout |
| [POST /users/{id}/change_username](#get-users) | Change username |
| [POST /users/{id}/change_password](#get-users) | Change password |
| :warning: [POST /users/recover_account](#get-users) | Recover an account in case if password was forgotten |
| :warning: [POST /users/reset_password](#get-users) | Reset password |

### Books

| URL  | Description |
| ---  | ----------- |
| [GET /books](#get-books)   | Find all books |
| [GET /books/{id}](#get-books)  | Find one book with specific id |
| [POST /books](#get-books) | Create new user book |
| [PUT /books/{id}](#get-books)  | Update book |
| [DELETE /books/{id}](#get-books)  | Delete book |
| :warning: [POST /books/{id}/file](#get-books) | Upload book file |
| :warning: [GET /books/{id}/file](#get-books) | Download book file |
| [DELETE /books/{id}/content](#get-books) | Delete book file |
| [DELETE /books/{id}/cover](#get-books) | Delete book cover |
| [POST /books/{id}/borrow](#get-books)  | Borrow book |
| [GET /books/{id}/readers](#get-books) | Find all book readers |
| [GET /users/{id}/books/read](#get-books)  | Find all books read by specific user |
| [GET /users/{id}/books/borrowed](#get-books)  | Find all books borrowed by specific user |
| [GET /users/{id}/books/added](#get-books) | Find all books which added by specific user |

### Reviews

| URL  | Description |
| ---  | ----------- |
| GET /books/{id} | Find all reviews for specific book |
| POST /book/{bookId}/review | Create new review |
| PUT /reviews/{id} | Update review |
| DELETE /reviews/{id} | Delete review |

### Borrowings

| URL  | Description |
| ---  | ----------- |
| GET /borrowings  | Find all borrowings |
| GET /user/{id}/borrowings | Get borrowings by user id |
| GET /user/current/borrowings | Get borrowings by current user |
| GET /borrowings/{id}  | Get borrowing by id |
| POST /borrowings/{id}/accept | Accept borrowing |
| POST /borrowings/{id}/reject | Reject borrowing |
| POST /borrowings/{id}/return | Return book |

## Detailed 
### Users

#### GET /users
---
**Summary:** Find all users

**Params**

| Param name | Description | Type | Example |
| ---------- | ----------- | ---- | ------- |
| name | Name matcher | string | name[0]=ohn+Smith&name[1]=Anna+Wats&name[2]=An |
| count | Count of users | integer | count=12 | 
| offset | Offset | integer | offset=3 |
| role | Role matcher (expected as array, set of avaiable values: admin, visitor, librarian)| string | role[0]=admin&role[1]=visitor |

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

#### GET /users/current
---
**Summary:** Get current user

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

#### POST /users/logout
---
**Summary:** Logout

**Response status**

| Code | Description |
| ---- | ----------- |
| 204 | OK, logged out |

#### PUT /users/{id}/change_email
---
**Summary:** Change users email

**Request body**
```json
{
  "password": "ivan",
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
  "old_password": "qwerty",
  "password": "1234"
}
```

**Response status**

| Code | Description |
| ---- | ----------- |
| 200 | Success |
| 401 | Unauthorized |
| 403 | Forbidden |

#### POST /users/recover_account
---
**Summary:** Request recovering an account in case password was forgotten. After request user will receive email with instructions to reset password

**Request body**
```json
{
  "email": "james_mortimer@baker_street221b.co.uk"
}
```

**Response status**

| Code | Description |
| ---- | ----------- |
| 200 | Success |

#### POST /users/reset_password
---
**Summary:** Reset password
**Request body**
```json
{
  "password": "qwerty",
  "token": "<JWT TOKEN>"
}
```

**Response status**

| Code | Description |
| ---- | ----------- |
| 200 | Success |
| 401 | Unauthorized |

### Books

#### GET /books
---
**Summary:** Find all books registered in library

**Params**

| Param name | Description |
| ---------- | ----------- |
| name | Name matcher |
| count | Count of books which are presented |
| offset | Offset |
| sort | Sort mode |

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
    ],
    "cover": "data:image/jpeg;base64,<BASE64 IMAGE>",
    "content": "data:application/pdf;base64,<BASE64 IMAGE>"
  }
]
```
**Response status**

| Code | Description |
| ---- | ----------- |
| 200 | Success |
| 401 | Unauthorized |

#### GET /books/{id}
---
**Summary:** Find book with specific id

**Response body**
```json
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
    ],
    "cover": "data:image/jpeg;base64,<BASE64 IMAGE>",
    "content": "data:application/pdf;base64,<BASE64 IMAGE>"
 }
```
**Response status**

| Code | Description |
| ---- | ----------- |
| 200 | Success |
| 401 | Unauthorized |

#### POST /books
---
**Summary:** Add new book

**Request body**
```json
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
    ],
    "cover": "data:image/jpeg;base64,<BASE64 IMAGE>",
    "content": "data:application/pdf;base64,<BASE64 IMAGE>"
 }
```

**Response body**
```json
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
    ],
    "cover": "data:image/jpeg;base64,<BASE64 IMAGE>",
    "content": "data:application/pdf;base64,<BASE64 IMAGE>"
 }
```
**Response status**

| Code | Description |
| ---- | ----------- |
| 200 | Success |
| 401 | Unauthorized |
| 403 | Forbidden |

#### PUT /books/{id}
---
**Summary:** Update book

**Request body**
```json
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
    ],
    "cover": "data:image/jpeg;base64,<BASE64 IMAGE>",
    "content": "data:application/pdf;base64,<BASE64 IMAGE>"
 }
```

**Response body**
```json
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
    ],
    "cover": "data:image/jpeg;base64,<BASE64 IMAGE>",
    "content": "data:application/pdf;base64,<BASE64 IMAGE>"
 }
```
**Response status**

| Code | Description |
| ---- | ----------- |
| 200 | Success |
| 401 | Unauthorized |
| 403 | Forbidden |

#### DELETE /books/{id}
---
**Summary:** Delete book

**Response status**

| Code | Description |
| ---- | ----------- |
| 200 | Success |
| 401 | Unauthorized |
| 403 | Forbidden |

#### POST /books/{id}/cover
---
**Summary:** Create book cover

**Request body**

```json
{
  "cover": "data:<MIME_TYPE>;base64,<DATA>"
}
```

**Response status**

| Code | Description |
| ---- | ----------- |
| 200 | Success |
| 401 | Unauthorized |
| 403 | Forbidden |

#### DELETE /books/{id}/cover
---
**Summary:** Delete book cover

**Response status**

| Code | Description |
| ---- | ----------- |
| 200 | Success |
| 401 | Unauthorized |
| 403 | Forbidden |

#### POST /books/{id}/content
---
**Summary:** Upload book file in PDF

**Request body**
PDF file

**Response status**

| Code | Description |
| ---- | ----------- |
| 200 | Success |
| 401 | Unauthorized |
| 403 | Forbidden |

#### DELETE /books/{id}/content
---
**Summary:** Delete book file

**Response status**

| Code | Description |
| ---- | ----------- |
| 200 | Success |
| 401 | Unauthorized |
| 403 | Forbidden |

#### POST /books/{id}/borrow
---
**Summary:** Order a borrowings of book with specific id

**Request body**
```json
{
	 "id": 1,
    "user_id": 1,
	"book_id": 1,
    "borrow_date": "2017-01-01",
    "return_date": null,
    "status": "ordered"
}
```

**Response status**

| Code | Description |
| ---- | ----------- |
| 200 | Success |
| 401 | Unauthorized |
| 403 | Forbidden |

#### GET /books/{id}/readers
---
**Summary:** Find all book's readers

**Response body**
```json
[
  {
    "id": 1,
    "name": "Иван",
    "surname": "Иванов",
    "email": "ivan@mail.ru"
  },
  {
    "id": 2,
    "name": "Алексей",
    "surname": "Алексеев",
    "email": "alex@mail.ru"
  }
]
```

**Response status**

| Code | Description |
| ---- | ----------- |
| 200 | Success |
| 401 | Unauthorized |
| 403 | Forbidden |

#### GET /users/{id}/books/read
---
**Summary:** Find all books read by specific user

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
| 403 | Forbidden |

#### GET /users/{id}/books/borrowed
---
**Summary:** Find all books borrowed by specific user

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
| 403 | Forbidden |

#### GET /users/{id}/books/added
---
**Summary:** Find all books which added by specific user

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
| 403 | Forbidden |

### Borrowings

#### GET /borrowings
---
**Summary:** Find all borrowings

**Response body**
```json
[
  {
    "id": 1,
    "user_id": 1,
    "book_id": 1,
    "borrow_date": null,
    "return_date": null,
    "status": "ordered"
  },
  {
   "id": 1,
    "user_id": 1,
    "book_id": 1,
    "borrow_date": "2017-01-01",
    "return_date": null,
    "status": "accepted"
  },
  {
   "id": 1,
    "user_id": 1,
    "book_id": 1,
    "borrow_date": null,
    "return_date": null,
    "status": "rejected"
  },
  {
    "id": 1,
    "user_id": 1,
    "book_id": 1,
    "borrow_date": "2017-01-01",
    "return_date": "2017-01-02",
    "status": "returned"
  }
]
```

**Response status**

| Code | Description |
| ---- | ----------- |
| 200 | Success |
| 401 | Unauthorized |
| 403 | Forbidden |

#### GET /user/current/borrowings
---
**Summary:** Find borrowings by current user

**Response body**
```json
[
  {
    "id": 1,
    "user_id": 1,
    "book_id": 1,
    "borrow_date": "2017-01-01",
    "return_date": "2017-01-02",
    "status": "returned"
  }
]
```

**Response status**

| Code | Description |
| ---- | ----------- |
| 200 | Success |
| 401 | Unauthorized |
| 403 | Forbidden |


#### GET /user/{id}/borrowings
---
**Summary:** Find borrowings by user with specified id

**Response body**
```json
[
  {
   "id": 1,
    "user_id": 1,
    "book_id": 1,
    "borrow_date": "2017-01-01",
    "return_date": "2017-01-02",
    "status": "returned"
  }
]
```

**Response status**

| Code | Description |
| ---- | ----------- |
| 200 | Success |
| 401 | Unauthorized |
| 403 | Forbidden |


#### POST /borrowings/{id}/accept
---
**Summary:** Accept borrowing

**Response body**
```json
{
    "id": 1,
    "user_id": 1,
    "book_id": 1,
    "borrow_date": "2017-01-01",
    "return_date": null,
    "status": "accepted"
 }
```

**Response status**

| Code | Description |
| ---- | ----------- |
| 200 | Success |
| 401 | Unauthorized |
| 403 | Forbidden if user is not staff (admin or librarian) |

#### POST /borrowings/{id}/reject
---
**Summary:** Reject borrowing

**Response body**
```json
{
   "id": 1,
    "user_id": 1,
    "book_id": 1,
    "borrow_date": "2017-01-01",
    "return_date": null,
    "status": "rejected"
 }
```

**Response status**

| Code | Description |
| ---- | ----------- |
| 200 | Success |
| 401 | Unauthorized |
| 403 | Forbidden if user is not staff (admin or librarian) |

#### POST /borrowings/{id}/borrow
---
**Summary:** Borrow book

**Response body**
```json
{
   "id": 1,
    "user_id": 1,
    "book_id": 1,
    "borrow_date": "2017-01-01",
    "return_date": "2017-01-01",
    "status": "borrowed"
 }
```

**Response status**

| Code | Description |
| ---- | ----------- |
| 200 | Success |
| 401 | Unauthorized |
| 403 | Forbidden if user is not staff (admin or librarian) |

#### POST /borrowings/{id}/return
---
**Summary:** Return book

**Response body**
```json
{
   "id": 1,
    "user_id": 1,
    "book_id": 1,
    "borrow_date": "2017-01-01",
    "return_date": "2017-01-01",
    "status": "returned"
 }
```

**Response status**

| Code | Description |
| ---- | ----------- |
| 200 | Success |
| 401 | Unauthorized |
| 403 | Forbidden if user is not staff (admin or librarian) |

### Reviews

#### GET /books/{id}/reviews
---
**Summary:** Find all reviews for specific book

**Response body**
```json
[
  {
    "id": 1,
    "user": {
      "id": 1,
      "name": "Иван",
      "surname": "Иванов",
      "email": "ivan@mail.ru"
    },
    "comments": "Excellent!",
    "mark": 10
  }
]
```

**Response status**

| Code | Description |
| ---- | ----------- |
| 200 | Success |
| 401 | Unauthorized |
| 403 | Forbidden |

#### POST /books/{id}/review
---
**Summary:** Create new review

**Request body**
```json
{
    "comments": "Excellent!",
    "mark": 10
}
```

**Response body**
```json
[
  {
    "id": 1,
    "user": {
      "id": 1,
      "name": "Иван",
      "surname": "Иванов",
      "email": "ivan@mail.ru"
    },
    "comments": "Excellent!",
    "mark": 10
  }
]
```

**Response status**

| Code | Description |
| ---- | ----------- |
| 200 | Success |
| 401 | Unauthorized |
| 403 | Forbidden |

#### PUT /books/{id}/reviews
---
**Summary:** Update review

**Request body**
```json
{
    "user_id": 1,
    "comments": "Excellent!",
    "mark": 10
}
```

**Response status**

| Code | Description |
| ---- | ----------- |
| 200 | Success |
| 401 | Unauthorized |
| 403 | Forbidden |

#### DELETE /reviews/{id}
---
**Summary:** Delete review with specific id

**Response status**

| Code | Description |
| ---- | ----------- |
| 200 | Success |
| 401 | Unauthorized |
| 403 | Forbidden |
