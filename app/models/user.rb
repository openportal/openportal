class User < ActiveRecord::Base
  before_validation :generate_slug
  has_secure_password

  validates_uniqueness_of :email, :username
  validates_presence_of :email

  validates :slug, uniqueness: true, presence: true,
                   exclusion: {in: %w[signup login logout]}

  def to_param
    slug
  end

  def generate_slug
    self.slug ||= username.parameterize
  end
  
  def self.by_prefix(prefix)
    return [] if prefix == ""

    where("username LIKE ?", "%#{prefix}%").order(:username)
    #where("username LIKE :uname", {uname: "%#{prefix}%"}).order(:username)
  end
end
