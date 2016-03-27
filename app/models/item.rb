class Item < ActiveRecord::Base
  has_one :detail, dependent: :destroy, class_name: ItemDetail
  accepts_nested_attributes_for :detail
end
