class CarrierStringIO < StringIO

  attr_accessor :original_file
  attr_accessor :content_type

  # def original_filename
  #   "photo.jpeg"
  # end
  #
  # def content_type
  #   # this should reflect real content type, but for this example it ok
  #   "image/jpeg"
  # end
end