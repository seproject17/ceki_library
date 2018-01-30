class Book < ApplicationRecord

  require 'base64'

  BOOKS_ROOT = File.join('public', 'uploads', 'books')

  MIME2IMG = {
      'image/gif' => 'gif',
      'image/jpeg' => 'jpeg',
      'image/png' => 'png'
  }
  IMG2MIME = {
      :gif => 'image/gif',
      :jpeg => 'image/jpeg',
      :png => 'image/png'
  }

  attr_writer :cover, :content
  attr_readonly :cover_path

  before_create :set_default_available_count
  after_create :save_content
  after_create :save_cover
  after_update :save_content
  after_update :save_cover
  after_destroy :delete_content
  after_destroy :delete_cover

  # mount_uploader :cover, BookCoverUploader
  # mount_uploader :file, BookFileUploader
  has_many :borrowings
  has_many :reviews

  def available?
    self.available_count > 0
  end

  def cover
    img_format = self.cover_path.split('.').last
    f = File.open(File.join(BOOKS_ROOT, self.cover_path), 'r')
    data = Base64.encode64(f.read)
    content = "data:#{IMG2MIME[img_format]};base64,#{data}="
    f.close
    content
  end

  def content
    f = File.open(content_name, 'r')
    base64_content = Base64.encode64(f.read)
    content = "data:application/pdf;base64,#{base64_content}="
    f.close
    content
  end

  def content_name
    File.join(BOOKS_ROOT, "#{self.id}_content.pdf")
  end

  private
  def set_default_available_count
    self.available_count = self.max_count
  end

  private
  def save_content
    if content == nil
      return
    end
    if content =~ /data:(application\/pdf);base64,([a-zA-Z0-9+\/]+)=/i
      data = $2
      open(content_name, 'w+') {|f|
        f << Base64.decode64(data)
      }
    else
      raise 'Not base64 content'
    end
  end

  private
  def save_cover
    if content == nil
      return
    end
    if cover =~ /data:(\w+\/\w+);base64,([a-zA-Z0-9+\/]+)=/i
      mime_type = $1
      data = $2
      open(cover_name(MIME2IMG[mime_type]), 'w+') {|f|
        f << Base64.decode64(data)
      }
    else
      raise 'Not base64 content'
    end
  end

  private
  def cover_name(img_format)
    File.join(BOOKS_ROOT, "#{self.id}_cover.#{img_format}")
  end

  private
  def delete_cover
    File.delete(File.join(BOOKS_ROOT, self.cover_path))
  end

  private
  def delete_content
    File.delete(content_name)
  end
end