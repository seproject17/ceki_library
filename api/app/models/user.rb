require 'securerandom'

class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attr, value)
    if value == nil
      record.errors[attr] << (options[:message] || 'Email is not presented')
    end
    unless value =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
      record.errors[attr] << (options[:message] || 'Value doest not correspond to an email format')
    end
    if record.new_record?
      if User.exists? :email => value
        record.errors[attr] << (options[:message] || 'User with this email already exists')
      end
    else
      if User.where.not(id: record.id).exists? :email => value
        record.errors[attr] << (options[:message] || 'User with this email already exists')
      end
    end
  end
end

class User < ApplicationRecord
  has_many :books, dependent: :delete_all
  has_many :borrowings, dependent: :delete_all
  has_many :reviews, dependent: :delete_all

  has_secure_password
  enum role: [:admin, :librarian, :visitor]
  validates_with EmailValidator, attributes: [:email]

  mount_base64_uploader :avatar, AvatarUploader

  # before_create :set_avatar_path
  # before_update :set_avatar_path
  # after_create :save_avatar
  # after_update :save_avatar
  # after_destroy :delete_avatar
  #
  # AVATAR_REGEX = /data:(image\/jpeg|image\/jpg|image\/png|image\/gif);base64,([a-zA-Z0-9+\/]+)=/i
  # MIME2IMG = {
  #     'image/gif' => 'gif',
  #     'image/jpeg' => 'jpeg',
  #     'image/png' => 'png',
  #     'image/jpg' => 'jpg'
  # }
  # IMG2MIME = {
  #     'gif' => 'image/gif',
  #     'jpeg' => 'image/jpeg',
  #     'png' => 'image/png',
  #     'jpg' => 'image/jpg'
  # }
  #
  # USERS_ROOT = File.join('public', 'uploads', 'users')
  #
  #
  # def admin?
  #   role == 'admin'
  # end
  #
  # def visitor?
  #   role == 'visitor'
  # end
  #
  # def librarian?
  #   role == 'librarian'
  # end
  #
  # def avatar=(avatar)
  #   @avatar = avatar
  # end
  #
  # def avatar
  #   if avatar_path.nil?
  #     return nil
  #   end
  #   img_format = avatar_path.split('.').last
  #   p img_format
  #   p avatar_path
  #   f = File.open(self.avatar_path, 'r')
  #   data = Base64.strict_encode64(f.read)
  #   avatar = "data:#{IMG2MIME[img_format]};base64,#{data}="
  #   f.close
  #   avatar
  # end
  #
  def as_json(options = {})
    super(options.merge({except: [:password_digest, :created_at, :updated_at]})).merge({avatar: self.avatar})
  end
  #
  # private
  # def set_avatar_path
  #   if @avatar == nil
  #     return
  #   end
  #   if @avatar =~ AVATAR_REGEX
  #     p 'Set avatar path'
  #     self.avatar_path = avatar_name(MIME2IMG[$1])
  #   end
  # end
  #
  # private
  # def save_avatar
  #   if @avatar == nil
  #     return
  #   end
  #   if @avatar =~ AVATAR_REGEX
  #     data = $2
  #     open(avatar_path, 'wb+') {|f|
  #       f << Base64.decode64(data)
  #     }
  #   else
  #     raise 'Not base64 content'
  #   end
  # end
  #
  # private
  # def delete_avatar
  #   p 'Delete avatar'
  #   p File.join(USERS_ROOT, self.avatar_path)
  #   p File.delete(File.join(USERS_ROOT, self.avatar_path))
  # end
  #
  # private
  # def avatar_name(img_format)
  #   File.join(USERS_ROOT, "#{SecureRandom.uuid}_avatar.#{img_format}")
  # end
end

