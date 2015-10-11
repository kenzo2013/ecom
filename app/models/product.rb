class Product < ActiveRecord::Base
  include RankedModel
  serialize :tag_list_ids
  serialize :category_ids
  searchkick autocomplete: ['title']
  ranks :row_product
  belongs_to :category
  belongs_to :tag
  mount_uploader :image, ImageUploader
  validates_presence_of :image
  validates_presence_of :name
  validates_presence_of :price
  validates_presence_of :weight
  validates_presence_of :description
  validates_presence_of :tag_list_ids
  validates_presence_of :category_ids
  
  def visible
    self.update_attributes(state: "visible")
  end
 
  def invisible
    self.update_attributes(state: "invisible")
  end
  def self.sort_filter(ids, price, weight )
    if ids and price and weight
      res = self.where(state: "visible").where(tag_list_ids: ids).order(price: :desc).order(weight: :desc)
      elsif ids and price 
        res = self.where(state: "visible").where(tag_list_ids: ids).order(price: :desc)
      elsif ids and weight
        res = self.where(state: "visible").where(tag_list_ids: ids).order(weight: :desc)
      elsif price and weight
        res = self.where(state: "visible").order(price: :desc).order(weight: :desc)
      elsif price
        res = self.where(state: "visible").order(price: :desc)
      elsif weight
        res = self.where(state: "visible").order(weight: :desc)
    else 
      res = self.where(state: "visible")
    end
  end
  
end
