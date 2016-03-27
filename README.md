

# Item model を作成

```
rails g scaffold item name:string price:integer
```

# ItemDetail model を作成

```
rails g model item_detail description:string item_id:integer
```

## 親子を設定

app/models/item.rb

```
class Item < ActiveRecord::Base
  has_one: item_detail
end
```

app/models/item_detail.rb

```
class ItemDetail < ActiveRecord::Base
  belongs_to :item
end
```

# Item の form で、item_detail も編集可能にする




