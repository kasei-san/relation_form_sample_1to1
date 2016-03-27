1:1のmodelを1つのformで編集可能にする方法

# 先に結論

`accepts_nested_attributes_for` を宣言することで、view にて、`fields_for` を使って子要素の編集も可能になる

# つくりかた

## Item model を作成

```ruby
rails g scaffold item name:string price:integer
```

## model `ItemDetail` を作成

```ruby
rails g model item_detail description:string item_id:integer
```

## 親子関係を設定

app/models/item.rb

```ruby
class Item < ActiveRecord::Base
  has_one :detail, dependent: :destroy, class_name: ItemDetail
end
```

- item_detail だと冗長なので model では detail で参照

app/models/item_detail.rb

```ruby
class ItemDetail < ActiveRecord::Base
  belongs_to :item
end
```

## `Item` の form で、 `ItemDetail` も編集可に

app/models/item.rb

```ruby
class Item < ActiveRecord::Base
  has_one :detail, dependent: :destroy, class_name: ItemDetail
  accepts_nested_attributes_for :detail
end
```

- `accepts_nested_attributes_for` を宣言することで、view にて、`fields_for` を使って子要素の編集も可能になる


## `ItemCotroller` にて、 `ItemDetail` のパラメータを許可

app/controllers/items_controller.rb

```ruby
    def item_params
      params.require(:item).permit(:name, :price, detail_attributes: %i[id description])
    end
```

## 新規作成時と、編集時に detail がない場合に、detail を build するように

app/controllers/items_controller.rb

```ruby
  # GET /items/new
  def new
    @item = Item.new
    @item.build_detail
  end

  # GET /items/1/edit
  def edit
    @item.build_detail unless @item.detail.present?
  end
```

## `Item` のform に `ItemDetail` を追加

app/views/items/_form.html.haml

```ruby
  .field
    = f.label :price
    %br/
    = f.number_field :price

  = f.fields_for :detail do |detail|
    = detail.label :description
    %br/
    = detail.text_field :description
```
