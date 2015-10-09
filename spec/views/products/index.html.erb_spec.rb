require 'rails_helper'

RSpec.describe "products/index", type: :view do
  before(:each) do
    assign(:products, [
      Product.create!(
        :name => "Name",
        :weight => "9.99",
        :price => "9.99",
        :description => "MyText",
        :tag_1 => "Tag 1",
        :tag_2 => "Tag 2",
        :tag_3 => "Tag 3"
      ),
      Product.create!(
        :name => "Name",
        :weight => "9.99",
        :price => "9.99",
        :description => "MyText",
        :tag_1 => "Tag 1",
        :tag_2 => "Tag 2",
        :tag_3 => "Tag 3"
      )
    ])
  end

  it "renders a list of products" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Tag 1".to_s, :count => 2
    assert_select "tr>td", :text => "Tag 2".to_s, :count => 2
    assert_select "tr>td", :text => "Tag 3".to_s, :count => 2
  end
end
