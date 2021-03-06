class User < ActiveRecord::Base
  has_many :attendances, dependent: :destroy
  attr_accessor :remember_token

  before_save :downcase_email

  validates :user_name, presence: true, length: {maximum: Settings.max_name},
    uniqueness: {case_sensitive: false}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:true, length: {maximum: Settings.max_email},
    format: {with: VALID_EMAIL_REGEX},
    uniqueness: {case_sensitive: false}
  validates :full_name, presence:true, length: {maximum: Settings.max_name}
  validates :password, presence: true, length: {minimum: Settings.min_password}

  has_secure_password

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
      BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  def nearest_attendance
    attendance = attendances.first
    if attendance.nil?
      ""
    else
      attendance.date
    end
  end

  def today
    time_now = Time.zone.now
    attendance = Attendance.find_by(user_id: id, date: time_now)
    if attendance.nil?
      "Not attendance"
    elsif attendance.time_out.present?
      "Done"
    else
      "Attendanced"
    end
  end

  private
    def downcase_email
      self.email = email.downcase
    end

end
