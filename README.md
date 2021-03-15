# README

## 使用方法
<br>

### アイデア登録

`localhost:3000/ideas`に対して下記Json形式でPOSTリクエストを送信。
```
{
    "category_name":"働き方改革",
    "body":"リモートワーク"
}
```

### アイデア取得
`localhost:3000/ideas`に対して下記Json形式でGETリクエストを送信。
```
{
    "category_name":"業務改善"
}
```