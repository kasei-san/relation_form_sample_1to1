class Item < ActiveRecord::Base
  has_one :item_detail, dependent: :destroy
  accepts_nested_attributes_for :item_detail
end
