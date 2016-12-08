class User < ActiveRecord::Base
  validates :username, :pw_digest, :session_token, presence: true
  validates :password, length: { minimum: 6, allow_nil: true }

  attr_reader :password

  before_validation :ensure_session_token

  has_many(
    :cats,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: "Cat"
  )

  def self.find_by_cred(username, password)
    user = User.find_by(username: username)
    return nil unless user
    user.is_password?(password) ? user : nil
  end

  def ensure_session_token
    self.session_token ||= SecureRandom::base64(128)
  end

  def reset_session_token!
    self.session_token = SecureRandom::base64(128)
    self.save
    self.session_token
  end

  def password=(password)
    @password = password
    self.pw_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.pw_digest).is_password?(password)
  end

end
