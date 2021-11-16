require 'rails_helper'

RSpec.describe User, type: :model do
	describe 'Validations' do
  	it 'should create a valid user if all fields are present' do
			@user = User.new(:name => "Bob", :email => "bob@gmail.com", :password => "bobpass", :password_confirmation => "bobpass")
			@user.save!
			expect(@user).to be_valid
		end

  	it 'is not valid without a password field' do
			@user = User.new(:name => "Bob", :email => "bob@gmail.com", :password_confirmation => "bobpass")
			expect(@user).to_not be_valid
			expect(@user.errors.messages[:password]).to include('can\'t be blank')
		end

		it "is not valid without a name field" do
      @user = User.new(:email => "bob@gmail.com", :password => "bobpass", :password_confirmation => "bobpass")
      expect(@user).to_not be_valid
      expect(@user.errors.messages[:name]).to include('can\'t be blank')
    end

		it "is not valid without an email field" do
      @user = User.new(:name => "bob", :password => "bobpass", :password_confirmation => "bobpass")
      expect(@user).to_not be_valid
      expect(@user.errors.messages[:email]).to include('can\'t be blank')
    end
		
		it "is not valid if passwords don't match" do
      @user = User.new(:name => "bob", :email => "bob@gmail.com", :password => "bobpass", :password_confirmation => "bobpas")
      expect(@user).to_not be_valid
      expect(@user.errors.messages[:password_confirmation]).to include('doesn\'t match Password')
    end
		
		it "is not valid if password is too short" do
			@user = User.new(:name => "bob", :email => "bob@gmail.com", :password => "bob", :password_confirmation => "bob")
			expect(@user).to_not be_valid
			expect(@user.errors.messages[:password]).to include('is too short (minimum is 5 characters)')
		end
	
		it "is not valid if email is not unique " do
      @user1 = User.new(:name => "bob", :email => "bob@gmail.com", :password => "bobpass", :password_confirmation => "bobpass")
      @user2 = User.new(:name => "bob", :email => "bob@gmail.com", :password => "bobpass", :password_confirmation => "bobpass")
      @user1.save
      @user2.save
			
			expect(@user1).to be_valid
      expect(@user2).to_not be_valid

      expect(@user2.errors.messages[:email]).to include('has already been taken')
    end

	end
end
