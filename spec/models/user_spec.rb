require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'Validations' do
    it "is valid" do
      user = User.new(
        name: 'name',
        email: 'test@test.com',
        password: 'password',
        password_confirmation: 'password'
      )
      expect(user).to be_valid
    end

    it "email is missing" do
      user = User.new(email: '')
      expect(user).to be_invalid
      expect(user.errors.full_messages).to include("Email can't be blank")
    end

    it "name is missing" do
      user = User.new(name: nil)
      expect(user).to be_invalid
      expect(user.errors.full_messages).to include("Name can't be blank")
    end

    it "password don't match" do
      user = User.new(
        name: 'name',
        email: 'test@test.com',
        password: 'password',
        password_confirmation: 'notpassword'
      )
      user.password = 'random'
      user.valid?
      expect(user.errors.full_messages).to be_present
    end

    it 'email must be unique' do
      user = User.new
      user.name = 'name'
      user.email = 'test@test.com'
      user.password = 'password'
      user.password_confirmation = 'password'

      user.save

      user2 = User.new
      user2.name = 'name'
      user2.email = 'test@test.com'
      user2.password = 'password'
      user2.password_confirmation = 'password'
      user2.save

      expect(user2.errors.full_messages).to include('Email has already been taken')
    end

    it 'password length less than 5 characters is invalid' do
      user = User.new
      user.name = 'name'
      user.email = 'test@test.com'
      user.password = 'no5'
      user.password_confirmation = 'no5'
      expect(user).to be_invalid
    end

    it 'password length must be at-least 5 characters' do
      user = User.new
      user.name = 'name'
      user.email = 'test@test.com'
      user.password = 'atleast5'
      user.password_confirmation = 'atleast5'
      expect(user).to be_valid
    end
  end

  describe '.authenticate_with_credentials' do
    it 'should pass with valid credentials' do
      user = User.new(
        name: 'name',
        email: 'test@test.com',
        password: 'password',
        password_confirmation: 'password'
      )
      user.save

      user = User.authenticate_with_credentials('test@test.com', 'password')
      expect(user).not_to be(nil)
    end

    it 'should not pass with invalid credentials' do
      user = User.new(
        name: 'name',
        email: 'test@test.com',
        password: 'password',
        password_confirmation: 'password'
      )
      user.save

      user = User.authenticate_with_credentials('test@test.com', 'pass')
      expect(user).to be(nil)
    end

    it 'should pass with spaces present in email' do
      user = User.new(
        name: 'name',
        email: 'test@test.com',
        password: 'password',
        password_confirmation: 'password'
      )
      user.save

      user = User.authenticate_with_credentials(' test@test.com ', 'password')
      expect(user).not_to be(nil)
    end

    it 'should pass with caps present in email' do
      user = User.new(
        name: 'name',
        email: 'test@test.com',
        password: 'password',
        password_confirmation: 'password'
      )
      user.save

      user = User.authenticate_with_credentials('tEsT@tEST.com', 'password')
      expect(user).not_to be(nil)
      end
      
    end

end