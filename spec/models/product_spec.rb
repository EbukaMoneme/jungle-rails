require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
		before do
			@category = Category.new(:name => 'Guitar')
		end

		it 'should save with all four value fields' do
			@product = Product.new(:name => 'Les Paul', :price => 100, :quantity => 2, :category => @category)
			@product.save!
			expect(@product).to be_present
		end

		it 'is not valid without a name field' do
			@product = Product.new(:price => 100, :quantity => 2, :category => @category)
			expect(@product).to_not be_valid
			expect(@product.errors.messages[:name]).to include('can\'t be blank')
		end

		it 'is not valid without a price field' do
			@product = Product.new(:name => 'Les Paul', :quantity => 2, :category => @category)
			expect(@product).to_not be_valid
			expect(@product.errors.messages[:price]).to include('can\'t be blank')
		end

		it 'is not valid without a quantity field' do
			@product = Product.new(:name => 'Les Paul', :price => 100, :category => @category)
			expect(@product).to_not be_valid
			expect(@product.errors.messages[:quantity]).to include('can\'t be blank')
		end

		it 'is not valid without a category field' do
			@product = Product.new(:name => 'Les Paul', :price => 100, :quantity => 2)
			expect(@product).to_not be_valid
			expect(@product.errors.messages[:category]).to include('can\'t be blank')
		end
	end
end
