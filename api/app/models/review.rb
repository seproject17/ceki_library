class Review < ApplicationRecord
  belongs_to :user, optional: false
  belongs_to :book, optional: false

  def as_json(options = {})
    @user = {
        'email': self.user.email,
        'name': self.user.name,
        'surname': self.user.surname,
        'id': self.user.id,
    }
    super((options || {})).merge({'user': @user})
  end
end
