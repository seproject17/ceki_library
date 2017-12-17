Библиотека ЦЭКИ
===============
Библиотека ЦЭКИ

**Version:** v1

### /users
---
##### ***GET***
**Summary:** Найти учетные записи всех пользователей

**Responses**

| Code | Description |
| ---- | ----------- |
| 200 | Успешная операция |

### /users/{id}
---
##### ***GET***
**Summary:** Вернуть учетную запись пользователя

**Parameters**

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| id | path | Уникальный идентификатор пользователя | Yes | integer (in64) |

**Responses**

| Code | Description |
| ---- | ----------- |
| 200 | Success response |

##### ***PUT***
**Summary:** Обновить учетную запись пользователя

**Parameters**

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| id | path | Уникальный идентификатор пользователя | Yes | integer (in64) |

**Responses**

| Code | Description |
| ---- | ----------- |
| 200 | Success response |

##### ***DELETE***
**Summary:** Удалить учетную запись пользователя

**Parameters**

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| id | path | Уникальный идентификатор пользователя | Yes | integer (in64) |

**Responses**

| Code | Description |
| ---- | ----------- |
| 200 | Success response |
