require 'rails_helper'

RSpec.describe "products/show", type: :view do
  before(:each) do
    @product = assign(:product, Product.create!(
      :name => "Name",
      :weight => "9.99",
      :price => "9.99",
      :description => "MyText",
      :tag_1 => "Tag 1",
      :tag_2 => "Tag 2",
      :tag_3 => "Tag 3"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/Tag 1/)
    expect(rendered).to match(/Tag 2/)
    expect(rendered).to match(/Tag 3/)
  end
end
