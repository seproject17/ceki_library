Библиотека ЦЭКИ
===============
Библиотека ЦЭКИ

**Version:** v1.0.0

## Summary
### Users

| URL  | Description |
| ---  | ----------- |
| [GET /users](#users)  | Find all users |
| [GET /users/{id}](#users) | Find one user with specific id |
| [POST /users](#users) | Create new user account |
| [PUT /users/{id}](#users) | Update user account |
| [DELETE /users/{id}](#users) | Delete user account |
| [POST /users/login](#users) | Login in system |
| [POST /users/{id}/change_username](#users) | Change username |
| [POST /users/{id}/change_password](#users) | Change password |

### Books

| URL  | Description |
| ---  | ----------- |
| GET /books  | Find all books |
| GET /books/{id} | Find one book with specific id |
| POST /books | Create new user book |
| PUT /books/{id} | Update book |
| DELETE /books/{id} | Delete book |
| POST /books/{id}/file | Upload book file |
| GET /books/{id}/file | Download book file |
| DELETE /books/{id}/file | Delete book file |
| POST /books/{id}/borrow | Borrow book |
| POST /books/{id}/return | Return book |
| GET /books/free | Find all books which have at least one free item |
| GET /books/{id}/readers | Find all book readers |
| GET /users/{id}/books/read | Find all books read by specific user |
| GET /users/{id}/books/borrowed | Find all books borrowed by specific user |
| GET /users/{id}/books/added | Find all books which added by specific user |

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

**Responses**

| Code | Description |
| ---- | ----------- |
| 200 | Success |

#### GET /users/{id}
---
**Summary:** Find one user with specific id

**Responses**

| Code | Description |
| ---- | ----------- |
| 200 | Success |

#### POST /users
---
**Summary:** Create new user account

**Responses**

| Code | Description |
| ---- | ----------- |
| 201 | New user account created |

#### PUT /users/{id}
---
**Summary:** Update user account

**Responses**

| Code | Description |
| ---- | ----------- |
| 200 | User account updated |

#### DELETE /users/{id}
---
**Summary:** Delete user account

**Responses**

| Code | Description |
| ---- | ----------- |
| 200 | User account deleted |

#### POST /users/login
---
**Summary:** Login in system

**Responses**

| Code | Description |
| ---- | ----------- |
| 200 | User was logged in |

#### PUT /users/{id}/change_email
---
**Summary:** Change users email

**Responses**

| Code | Description |
| ---- | ----------- |
| 200 | Success |

#### PUT /users/{id}/change_password
---
**Summary:** Change users password

**Responses**

| Code | Description |
| ---- | ----------- |
| 200 | Success |
