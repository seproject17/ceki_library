require 'base64'

class Book < ApplicationRecord

  belongs_to :user
  has_many :borrowings
  has_many :reviews
  mount_base64_uploader :cover, BookCoverUploader
  mount_uploader :content, BookFileUploader

  # BOOKS_ROOT = File.join('public', 'uploads', 'books')
  #
  # MIME2IMG = {
  #     'image/gif' => 'gif',
  #     'image/jpeg' => 'jpeg',
  #     'image/png' => 'png'
  # }
  # IMG2MIME = {
  #     'gif' => 'image/gif',
  #     'jpeg' => 'image/jpeg',
  #     'png' => 'image/png',
  #     'jpg' => 'image/jpg'
  # }


  before_create :set_default_available_count
  # before_create :set_cover_path
  # before_update :set_cover_path
  # after_create :save_content
  # after_create :save_cover
  # after_update :save_content
  # after_update :save_cover
  # after_destroy :delete_content
  # after_destroy :delete_cover

  def available?
    self.available_count > 0
  end

  # def cover=(cover)
  #   @cover = cover
  # end
  #
  # def content=(content)
  #   @content = content
  # end
  #
  # def cover
  #   if cover_path.nil?
  #     return nil
  #   end
  #   img_format = cover_path.split('.').last
  #   p img_format
  #   f = File.open(self.cover_path, 'r')
  #   data = Base64.encode64(f.read)
  #   content = "data:#{IMG2MIME[img_format]};base64,#{data}="
  #   f.close
  #   content
  # end
  #
  # def content
  #   unless File.exists? content_name
  #     return nil
  #   end
  #   f = File.open(content_name, 'r')
  #   base64_content = Base64.encode64(f.read)
  #   content = "data:application/pdf;base64,#{base64_content}="
  #   f.close
  #   content
  # end
  #
  # def content_name
  #   File.join(BOOKS_ROOT, "#{self.id}_content.pdf")
  # end
  #
  # def delete_cover
  #   File.delete(File.join(BOOKS_ROOT, self.cover_path))
  # end
  #
  # def delete_content
  #   File.delete(content_name)
  # end

  def as_json(options = {})
    super((options || {}).merge({except: [:cover_path]})).merge({cover: cover}).merge({content: content})
  end

  # private
  # def set_cover_path
  #   if @cover =~ /data:(\w+\/\w+);base64,([a-zA-Z0-9+\/]+)=/i
  #     p 'Set cover path'
  #     self.cover_path = cover_name(MIME2IMG[$1])
  #   end
  # end

  private
  def set_default_available_count
    self.available_count = self.available_count || self.max_count
  end

  # private
  # def save_content
  #   if @content == nil
  #     return
  #   end
  #   if @content =~ /data:(application\/pdf);base64,([a-zA-Z0-9+\/]+)=/i
  #     data = $2
  #     open(content_name, 'wb+') {|f|
  #       f << Base64.decode64(data)
  #     }
  #   else
  #     raise 'Not base64 content'
  #   end
  # end
  #
  # private
  # def save_cover
  #   if @cover == nil
  #     return
  #   end
  #   if @cover =~ /data:(\w+\/\w+);base64,([a-zA-Z0-9+\/]+)=/i
  #     mime_type = $1
  #     data = $2
  #     open(cover_name(MIME2IMG[mime_type]), 'wb+') {|f|
  #       f << Base64.decode64(data)
  #     }
  #   else
  #     raise 'Not base64 content'
  #   end
  # end
  #
  # private
  # def cover_name(img_format)
  #   File.join(BOOKS_ROOT, "#{self.id}_cover.#{img_format}")
  # end
end