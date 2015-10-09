class Product < ActiveRecord::Base
  serialize :tag_list
  serialize :category_ids
  belongs_to :category
  mount_uploader :image, ImageUploader
  validates_presence_of :image
  validates_presence_of :name
  validates_presence_of :price
  validates_presence_of :weight
  validates_presence_of :description
  validates_presence_of :tag_list
end
