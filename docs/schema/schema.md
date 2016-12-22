# Sample API JSON Schema

In this schema file, we represents the public interface of Sample API in JSON Hyper Schema draft v4.

## <a name="resource-asin">ASIN</a>

Stability: `prototype`

Amazon.co.jpのASINコードをもとにデータを操作する

### Attributes

| Name | Type | Description | Example |
| ------- | ------- | ------- | ------- |
| **created_at** | *date-time* | when asin was created | `"2015-01-01T12:00:00Z"` |
| **id** | *uuid* | unique identifier of asin | `"01234567-89ab-cdef-0123-456789abcdef"` |
| **name** | *string* | unique name of asin | `"example"` |
| **updated_at** | *date-time* | when asin was updated | `"2015-01-01T12:00:00Z"` |

### ASIN Create

Create a new asin.

```
POST /asins
```


#### Curl Example

```bash
$ curl -n -X POST https://example.com/asins \
  -d '{
}' \
  -H "Content-Type: application/json"
```


#### Response Example

```
HTTP/1.1 201 Created
```

```json
{
  "created_at": "2015-01-01T12:00:00Z",
  "id": "01234567-89ab-cdef-0123-456789abcdef",
  "name": "example",
  "updated_at": "2015-01-01T12:00:00Z"
}
```

### ASIN Delete

Delete an existing asin.

```
DELETE /asins/{asin_id_or_name}
```


#### Curl Example

```bash
$ curl -n -X DELETE https://example.com/asins/$ASIN_ID_OR_NAME \
  -H "Content-Type: application/json"
```


#### Response Example

```
HTTP/1.1 200 OK
```

```json
{
  "created_at": "2015-01-01T12:00:00Z",
  "id": "01234567-89ab-cdef-0123-456789abcdef",
  "name": "example",
  "updated_at": "2015-01-01T12:00:00Z"
}
```

### ASIN Info

Info for existing asin.

```
GET /asins/{asin_id_or_name}
```


#### Curl Example

```bash
$ curl -n https://example.com/asins/$ASIN_ID_OR_NAME
```


#### Response Example

```
HTTP/1.1 200 OK
```

```json
{
  "created_at": "2015-01-01T12:00:00Z",
  "id": "01234567-89ab-cdef-0123-456789abcdef",
  "name": "example",
  "updated_at": "2015-01-01T12:00:00Z"
}
```

### ASIN List

List existing asins.

```
GET /asins
```


#### Curl Example

```bash
$ curl -n https://example.com/asins
```


#### Response Example

```
HTTP/1.1 200 OK
```

```json
[
  {
    "created_at": "2015-01-01T12:00:00Z",
    "id": "01234567-89ab-cdef-0123-456789abcdef",
    "name": "example",
    "updated_at": "2015-01-01T12:00:00Z"
  }
]
```

### ASIN Update

Update an existing asin.

```
PATCH /asins/{asin_id_or_name}
```


#### Curl Example

```bash
$ curl -n -X PATCH https://example.com/asins/$ASIN_ID_OR_NAME \
  -d '{
}' \
  -H "Content-Type: application/json"
```


#### Response Example

```
HTTP/1.1 200 OK
```

```json
{
  "created_at": "2015-01-01T12:00:00Z",
  "id": "01234567-89ab-cdef-0123-456789abcdef",
  "name": "example",
  "updated_at": "2015-01-01T12:00:00Z"
}
```


