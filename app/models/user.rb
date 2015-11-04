class User < ActiveRecord::Base
  has_many :posts
  has_secure_password

  validates :email, presence: true,
            uniqueness: true,
            format: {
                with: %r{
                  (?=[a-zA-Z0-9@.!#$%&'*+/=?^_`{|}~-]{6,254}\z)
                  (?=[a-zA-Z0-9!#$%&'*+/=?^_`{|}~-]{1,64}@)
                  [a-zA-Z0-9!#$%&'*+/=?^_`{|}~-]+
                  (?:\.[a-zA-Z0-9!#$%&'*+/=?^_`{|}~-]+)*
                  @(?:(?=[a-zA-Z0-9-]{1,63}\.)
                  [a-zA-Z0-9](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?\.)+
                  (?=[a-zA-Z0-9-]{1,63}\z)[a-zA-Z0-9]
                  (?:[a-zA-Z0-9-]*[a-zA-Z0-9])?
                }x
            }

  before_save :downcase_email

  def downcase_email
    self.email = email.downcase
  end
end
