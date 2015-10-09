require 'rails_helper'

RSpec.describe "products/edit", type: :view do
  before(:each) do
    @product = assign(:product, Product.create!(
      :name => "MyString",
      :weight => "9.99",
      :price => "9.99",
      :description => "MyText",
      :tag_1 => "MyString",
      :tag_2 => "MyString",
      :tag_3 => "MyString"
    ))
  end

  it "renders the edit product form" do
    render

    assert_select "form[action=?][method=?]", product_path(@product), "post" do

      assert_select "input#product_name[name=?]", "product[name]"

      assert_select "input#product_weight[name=?]", "product[weight]"

      assert_select "input#product_price[name=?]", "product[price]"

      assert_select "textarea#product_description[name=?]", "product[description]"

      assert_select "input#product_tag_1[name=?]", "product[tag_1]"

      assert_select "input#product_tag_2[name=?]", "product[tag_2]"

      assert_select "input#product_tag_3[name=?]", "product[tag_3]"
    end
  end
end
