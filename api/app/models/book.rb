require 'base64'

class Book < ApplicationRecord

  belongs_to :user
  has_many :borrowings
  has_many :reviews
  has_and_belongs_to_many :tags
  mount_uploader :cover, BookCoverUploader
  mount_uploader :content, BookFileUploader

  scope :title, -> (title) {where title: title}
  scope :title_starts_with, -> (title) {(where 'title LIKE ?', "#{title}%")}
  scope :title_ends_with, -> (title) {where('title LIKE ?', "%#{title}")}
  scope :title_matches, -> (title) {
    # select {|book|
    #   book.title.present? && (title.include? book.title)
    # }
    where("title is not NULL AND title <> ''").where("lower(title) LIKE lower(?)", "%#{title}%")
        .or(where("lower(?) LIKE '%' || lower(title) || '%'", title))
  }
  scope :isbn, -> (isbn) {where isbn: isbn}
  scope :isbn_starts_with, -> (isbn) {(where 'isbn LIKE ?', "#{isbn}%")}
  scope :isbn_ends_with, -> (isbn) {(where 'isbn LIKE ?', "%#{isbn}")}
  scope :isbn_matches, -> (isbn) {
    where("isbn is not NULL AND isbn <> ''").where("isbn LIKE ?", "%#{isbn}%")
        .or(where("lower(?) LIKE '%' || lower(isbn) || '%'", isbn))
  }
  scope :author_matches, -> (author) {
    where("author is not NULL AND author <> ''").where("lower(author) LIKE lower(?)", "%#{author}%")
        .or(where("lower(?) LIKE '%' || lower(author) || '%'", author))
  }
  scope :publisher_matches, -> (publisher) {
    where("publisher is not NULL AND publisher <> ''").where("lower(publisher) LIKE lower(?)", "%#{publisher}%")
        .or(where("lower(?) LIKE '%' || lower(publisher) || '%'", publisher))
  }
  scope :annotations_matches, -> (annotations) {
    where("annotations is not NULL AND annotations <> ''").where("lower(annotations) LIKE lower(?)", "%#{annotations}%")
        .or(where("lower(?) LIKE '%' || lower(annotations) || '%'", annotations))
  }


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
    super((options || {}).merge({except: [:cover_path]}))
        .merge(
            {
                cover: cover, content: content,
                tags: self.tags
            }
        )
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