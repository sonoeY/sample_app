class User < ApplicationRecord
   # :length & :maximum --> name属性とemail属性に長さの検証を追加する
  before_save { self.email = email.downcase }
  validates :name, presence: true, length: { maximum: 50 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence:   true, length: { maximum: 255 },
                    format:     { with: VALID_EMAIL_REGEX },
                    #メールアドレスの一意性を検証する
                    uniqueness: true
    
    #Userモデルにhas_secure_passwordを追加する
    has_secure_password
    validates :password, presence: true, length: { minimum: 6 }
end
