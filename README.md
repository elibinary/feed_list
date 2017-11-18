# README

## Base

* ruby 2.4.0, rails 5.1.4

## Dependencies

* MySQL, Redis 

## Run

```
reids: 127.0.0.1:6379
```

## Test

```
bundle exec rspec
```

## API

Your can generate test data

```ruby
rake generate_test_data:users
```

  
  > 所有接口都需要携带身份凭证（feed_token），可以放在 Headers 中或者直接在请求参数中携带
  
  
  
  ```
  Header: { 'FEED-TOKEN' => 'eyJhbGciOiJIUzI1NiJ9.eyJvcGVuaWQiOiJmOGU2NmRmNWVjZWI0ZGMyOWVmNjlkMzU3Mjc2NTlmZCIsImV4cCI6MTUxMjQxMTgzNn0.Cv5khl0sU8w5KBASOwlwTRerPw1hveUd3AEfjDByxeg' }
  ```
  
  ```
  params: { feed_token: 'eyJhbGciOiJIUzI1NiJ9.eyJvcGVuaWQiOiJmOGU2NmRmNWVjZWI0ZGMyOWVmNjlkMzU3Mjc2NTlmZCIsImV4cCI6MTUxMjQxMTgzNn0.Cv5khl0sU8w5KBASOwlwTRerPw1hveUd3AEfjDByxeg' }
  ```
  
  
  
  ## 获取事件列表 [ GET /api/v1/events ]
  
  ### Request
  
  ```ruby
    {
      team: 'team 的 safe_code，[必填]',
      project: 'project 的 safe_code，[选填] 不传则默认为全部',
      user_key: '返回某个用户的事件，[选填] 不传则默认全部',
      page: '[选填] 默认为 1',
      per: '[选填] 默认为 50'
    }
  ```
  
  
  ### Response
  
  ```
    {
        "events" => [
            {
                 "user_name": "fde1b840e7659c628fe1",
                  "user_key": "b32266c2af6d450aa421fb0e50bd1625",
                "avatar_url": nil,
                   "content": {
                       "type": "team",
                         "id": "acc0a20150bd4db0816f4f6aefb690b5",
                       "name": "592123c6f1041cfa582c",
                    "content": "创建了团队"
                },
                  "superior": {
                    "type": "team",
                      "id": "acc0a20150bd4db0816f4f6aefb690b5",
                    "name": "592123c6f1041cfa582c"
                },
                "created_at": "2017-11-18T14:29:56.000Z"
            }
        ]
    } 
  ```
  
  
  
  ### Example (curl)
  
  ```
 curl -X GET \
   'http://localhost:3000/api/v1/events?team=84b4e686553e4364a808f95482a64a38' \
   -H 'cache-control: no-cache' \
   -H 'feed-token: eyJhbGciOiJIUzI1NiJ9.eyJvcGVuaWQiOiIzZTczYTA2M2QwNmM0NGNlYTNkZmViNzY2MDZkMzdjZCIsImV4cCI6MTUxMzU4Njk4OX0.OgdKvVxeVHthe108jgSXuxz-NaaewNWO3eD198ivg1o' \
   -H 'postman-token: e4426087-8be2-a3ce-eb58-1b65cd74611c' 
  ```

