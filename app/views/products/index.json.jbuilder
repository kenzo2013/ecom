json.array!(@products) do |product|
  json.extract! product, :id, :name, :weight, :price, :description, :tag_1, :tag_2, :tag_3
  json.url product_url(product, format: :json)
end
