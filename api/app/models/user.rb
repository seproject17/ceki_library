class User < ApplicationRecord
  has_secure_password
  enum role: [:admin, :librarian, :visitor]
end
