require 'rails_helper'
require 'base64'

RESOURCES_ROOT = File.join(File.expand_path('..', File.dirname(__FILE__)), 'resources')
AVATAR_PATH = File.join(RESOURCES_ROOT, 'avatar.jpg')
BASE64_IMG_REGEX = /data:(image\/gif|image\/jpeg|image\/png);base64,([a-zA-Z0-9+\/]+)=/i

IMG2MIME = {
    :gif => 'image/gif',
    :jpeg => 'image/jpeg',
    :png => 'image/png',
    :jpg => 'image/jpg'
}

def file2base64(file_path)
  img_type = file_path.split('.').last.to_sym
  f = File.open(file_path, 'r')
  base64_content = Base64.strict_encode64(f.read)
  "data:#{IMG2MIME[img_type]};base64,#{base64_content}="
end

RSpec.describe User, type: :model do
  before :each do
    User.create name: 'Admin name', surname: 'Admin surname', email: 'admin@mail.ru', password: 'admin_password', role: 'admin'
    User.create name: 'Visitor name', surname: 'Visitor surname', email: 'visitor@mail.ru', password: 'visitor_password', role: 'visitor'
    User.create name: 'Librarian name', surname: 'Librarian surname', email: 'librarian@mail.ru', password: 'librarian_password', role: 'librarian'
  end
  describe 'Disallow to create a user' do
    it 'Nil email' do

      user = User.new name: 'Name', surname: 'Surname', password: 'qwerty', role: 'visitor'
      expect(user.valid?).to be_falsey
      expect(user.save).to be_falsey
    end
    it 'String doest not matches to email' do
      user = User.new name: 'Name', surname: 'Surname', password: 'qwerty', role: 'visitor', email: 'adaa@'
      expect(user.valid?).to be_falsey
      expect(user.save).to be_falsey

      user = User.new name: 'Name', surname: 'Surname', password: 'qwerty', role: 'visitor', email: '@44545'
      expect(user.valid?).to be_falsey
      expect(user.save).to be_falsey

      user = User.new name: 'Name', surname: 'Surname', password: 'qwerty', role: 'visitor', email: 'afa393939'
      expect(user.valid?).to be_falsey
      expect(user.save).to be_falsey

      user = User.new name: 'Name', surname: 'Surname', password: 'qwerty', role: 'visitor', email: ''
      expect(user.valid?).to be_falsey
      expect(user.save).to be_falsey
    end
    it 'String doest not matches to email' do
      user = User.new name: 'Name', surname: 'Surname', password: 'qwerty', role: 'visitor', email: 'adaa@'
      expect(user.valid?).to be_falsey
      expect(user.save).to be_falsey

      user = User.new name: 'Name', surname: 'Surname', password: 'qwerty', role: 'visitor', email: '343@'
      expect(user.valid?).to be_falsey
      expect(user.save).to be_falsey

      user = User.new name: 'Name', surname: 'Surname', password: 'qwerty', role: 'visitor', email: 'afa393939'
      expect(user.valid?).to be_falsey
      expect(user.save).to be_falsey

      user = User.new name: 'Name', surname: 'Surname', password: 'qwerty', role: 'visitor', email: ''
      expect(user.valid?).to be_falsey
      expect(user.save).to be_falsey
    end
    it 'User with email already exists' do
      user = User.new name: 'New Admin name', surname: 'New Admin surname', email: 'admin@mail.ru', password: 'admin_password', role: 'admin'
      expect(user.valid?).to be_falsey
      expect(user.save).to be_falsey
    end
  end

  describe 'Create user' do
    it 'Save avatar' do
      user = User.new name: 'Name', surname: 'Surname', password: 'qwerty',
                      role: 'visitor', email: 'new_admin@mail.ru'
      avatar = file2base64 AVATAR_PATH
      p avatar
      user.avatar = avatar
      expect(user.save).to be_truthy
      user = User.find_by_email 'new_admin@mail.ru'
      saved_avatar = user.avatar
      expect(saved_avatar).should_not be_nil
      expect(saved_avatar).to eq avatar
    end
  end

  describe 'Update user' do
    it 'Update avatar' do
      user = User.find_by_email 'admin@mail.ru'
      avatar = file2base64 AVATAR_PATH
      user.avatar = avatar
      user.save
      user = User.find_by_email 'admin@mail.ru'
      p user
      saved_avatar = user.avatar
      expect(saved_avatar).should_not be_nil
      expect(saved_avatar).to eq avatar
    end
  end

  describe 'Delete user' do
    it 'Destroy avatar' do
      user = User.find_by_email 'admin@mail.ru'
      avatar = file2base64 AVATAR_PATH
      user.avatar = avatar
      user.save
      avatar_path = user.avatar_path
      p user
      user.delete
      expect(File.exists? avatar_path).to be_falsey
    end
  end
end