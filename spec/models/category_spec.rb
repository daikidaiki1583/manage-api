require 'rails_helper'

RSpec.describe Category, type: :model do
  it 'is invalid' do
    expect(Category.new).to be_valid
  end

  it 'is not valid without a name' do
    Category.create(name: 'check')
    @category = Category.new(name: 'check')
    @category.valid?
    expect(@category.valid?).to eq(false)
  end
end
