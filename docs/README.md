# Sample API JSON Schema

In this schema file, we represents the public interface of Sample API in JSON Hyper Schema draft v4.

## The table of contents

- <a href="#resource-kindle">Kindle</a>
  - <a href="#link-GET-kindle-/kindles/{(%23%2Fdefinitions%2Fkindle%2Fdefinitions%2Fidentity)}">GET /kindles/{kindle_id}</a>
  - <a href="#link-POST-kindle-/kindles">POST /kindles</a>
  - <a href="#link-PATCH-kindle-/kindles/{(%23%2Fdefinitions%2Fkindle%2Fdefinitions%2Fidentity)}">PATCH /kindles/{kindle_id}</a>

## <a name="resource-kindle">Kindle</a>

Stability: `prototype`

Amazon.co.jpのKindleデータを操作する

### Attributes

| Name | Type | Description | Example |
| ------- | ------- | ------- | ------- |
| **authors** | *array* | Authors of kindle - API Author | `["メーブ","恵広史"]` |
| **created_at** | *date-time* | when kindle was created | `"2015-01-01T12:00:00Z"` |
| **id** | *string* | ASIN code (unique identifier)<br/> **pattern:** `^[0-9A-Z]{10}$` | `"B01N3PNATY"` |
| **images:large** | *uri* | Image (h500,w336) - API ImageSet/LargeImage/URL<br/> **pattern:** `^https://images-fe\.ssl-images-amazon\.com/images/.*?(no-image-no-ciu)?\.(gif|jpg)$` | `"https://images-fe.ssl-images-amazon.com/images/G/09/nav2/dp/no-image-no-ciu.gif"` |
| **images:medium** | *uri* | Image (h160,w108) - API ImageSet/MediumImage/URL<br/> **pattern:** `^https://images-fe\.ssl-images-amazon\.com/images/.*?(no-image-no-ciu)?\._SL160_\.(gif|jpg)$` | `"https://images-fe.ssl-images-amazon.com/images/I/51ZcS0q0-BL._SL160_.jpg"` |
| **images:small** | *uri* | Image (h75,w50) - API ImageSet/SmallImage/URL<br/> **pattern:** `^https://images-fe\.ssl-images-amazon\.com/images/.*?(no-image-no-ciu)?\._SL75_\.(gif|jpg)$` | `"https://images-fe.ssl-images-amazon.com/images/I/51ZcS0q0-BL._SL75_.jpg"` |
| **images:swatch** | *uri* | Image (h30,w20) - API ImageSet/SwatchImage/URL<br/> **pattern:** `^https://images-fe\.ssl-images-amazon\.com/images/.*?(no-image-no-ciu)?\._SL30_\.(gif|jpg)$` | `"https://images-fe.ssl-images-amazon.com/images/I/51ZcS0q0-BL._SL30_.jpg"` |
| **images:tiny** | *uri* | Image (h110,w74) - API ImageSet/TinyImage/URL<br/> **pattern:** `^https://images-fe\.ssl-images-amazon\.com/images/.*?(no-image-no-ciu)?\._SL110_\.(gif|jpg)$` | `"https://images-fe.ssl-images-amazon.com/images/I/51ZcS0q0-BL._SL110_.jpg"` |
| **published_at** | *date-time* | when kindle was released (API PublicationDate) | `"2015-01-01T12:00:00Z"` |
| **publisher** | *string* | Publisher of kindle - API Publisher | `"講談社"` |
| **title** | *string* | Title of kindle | `"バトルスタディーズ（８） (モーニングコミックス)"` |
| **updated_at** | *date-time* | when kindle was updated | `"2015-01-01T12:00:00Z"` |
| **url** | *uri* | Detail page URL of kindle - API DetailPageURL<br/> **pattern:** `^https://(www\.)?amazon\.co\.jp/o/ASIN/[0-9A-Z]{10}/habitec-22/?$` | `"https://www.amazon.co.jp/o/ASIN/B00EI2Y81I/habitec-22/"` |

### <a name="link-GET-kindle-/kindles/{(%23%2Fdefinitions%2Fkindle%2Fdefinitions%2Fidentity)}">Kindle Info</a>

Info for existing kindle.

```
GET /kindles/{kindle_id}
```


#### Curl Example

```bash
$ curl -n https://example.com/kindles/$KINDLE_ID
```


#### Response Example

```
HTTP/1.1 200 OK
```

```json
{
  "id": "B01N3PNATY",
  "title": "バトルスタディーズ（８） (モーニングコミックス)",
  "authors": [
    "メーブ",
    "恵広史"
  ],
  "publisher": "講談社",
  "url": "https://www.amazon.co.jp/o/ASIN/B00EI2Y81I/habitec-22/",
  "images": {
    "swatch": "https://images-fe.ssl-images-amazon.com/images/I/51ZcS0q0-BL._SL30_.jpg",
    "small": "https://images-fe.ssl-images-amazon.com/images/I/51ZcS0q0-BL._SL75_.jpg",
    "tiny": "https://images-fe.ssl-images-amazon.com/images/I/51ZcS0q0-BL._SL110_.jpg",
    "medium": "https://images-fe.ssl-images-amazon.com/images/I/51ZcS0q0-BL._SL160_.jpg",
    "large": "https://images-fe.ssl-images-amazon.com/images/G/09/nav2/dp/no-image-no-ciu.gif"
  },
  "published_at": "2015-01-01T12:00:00Z",
  "created_at": "2015-01-01T12:00:00Z",
  "updated_at": "2015-01-01T12:00:00Z"
}
```

### <a name="link-POST-kindle-/kindles">Kindle Create</a>

Create a new kindle.

```
POST /kindles
```

#### Required Parameters

| Name | Type | Description | Example |
| ------- | ------- | ------- | ------- |
| **id** | *string* | ASIN code (unique identifier)<br/> **pattern:** `^[0-9A-Z]{10}$` | `"B01N3PNATY"` |



#### Curl Example

```bash
$ curl -n -X POST https://example.com/kindles \
  -d '{
  "id": "B01N3PNATY"
}' \
  -H "Content-Type: application/json"
```


#### Response Example

```
HTTP/1.1 201 Created
```

```json
{
  "id": "B01N3PNATY",
  "title": "バトルスタディーズ（８） (モーニングコミックス)",
  "authors": [
    "メーブ",
    "恵広史"
  ],
  "publisher": "講談社",
  "url": "https://www.amazon.co.jp/o/ASIN/B00EI2Y81I/habitec-22/",
  "images": {
    "swatch": "https://images-fe.ssl-images-amazon.com/images/I/51ZcS0q0-BL._SL30_.jpg",
    "small": "https://images-fe.ssl-images-amazon.com/images/I/51ZcS0q0-BL._SL75_.jpg",
    "tiny": "https://images-fe.ssl-images-amazon.com/images/I/51ZcS0q0-BL._SL110_.jpg",
    "medium": "https://images-fe.ssl-images-amazon.com/images/I/51ZcS0q0-BL._SL160_.jpg",
    "large": "https://images-fe.ssl-images-amazon.com/images/G/09/nav2/dp/no-image-no-ciu.gif"
  },
  "published_at": "2015-01-01T12:00:00Z",
  "created_at": "2015-01-01T12:00:00Z",
  "updated_at": "2015-01-01T12:00:00Z"
}
```

### <a name="link-PATCH-kindle-/kindles/{(%23%2Fdefinitions%2Fkindle%2Fdefinitions%2Fidentity)}">Kindle Update</a>

Update an existing kindle.

```
PATCH /kindles/{kindle_id}
```


#### Curl Example

```bash
$ curl -n -X PATCH https://example.com/kindles/$KINDLE_ID \
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
  "id": "B01N3PNATY",
  "title": "バトルスタディーズ（８） (モーニングコミックス)",
  "authors": [
    "メーブ",
    "恵広史"
  ],
  "publisher": "講談社",
  "url": "https://www.amazon.co.jp/o/ASIN/B00EI2Y81I/habitec-22/",
  "images": {
    "swatch": "https://images-fe.ssl-images-amazon.com/images/I/51ZcS0q0-BL._SL30_.jpg",
    "small": "https://images-fe.ssl-images-amazon.com/images/I/51ZcS0q0-BL._SL75_.jpg",
    "tiny": "https://images-fe.ssl-images-amazon.com/images/I/51ZcS0q0-BL._SL110_.jpg",
    "medium": "https://images-fe.ssl-images-amazon.com/images/I/51ZcS0q0-BL._SL160_.jpg",
    "large": "https://images-fe.ssl-images-amazon.com/images/G/09/nav2/dp/no-image-no-ciu.gif"
  },
  "published_at": "2015-01-01T12:00:00Z",
  "created_at": "2015-01-01T12:00:00Z",
  "updated_at": "2015-01-01T12:00:00Z"
}
```


