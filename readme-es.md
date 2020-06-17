# Es 使用


```bash
# 查看健康状态
curl -XGET localhost:9200/

# 查看所有索引
curl 'localhost:9200/_cat/indices?v'
```



curl -H "Content-Type: application/json" -XGET 'localhost:9200/kgflow-log/_search?pretty' -d '
{
  "query": {
    "bool": {
      "must": [
        {
          "term": {
            "key.keyword": {
              "value": "three_tuple_import_tianming1589858475761"
            }
          }
        }
      ]
    }
  },
  "from": 0,
  "size": 1000,
  "sort": [
    {
      "timestamp": {
        "order": "asc"
      }
    }
  ]
}'
