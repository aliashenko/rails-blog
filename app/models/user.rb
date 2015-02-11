class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :posts, dependent: :destroy
  validates_presence_of :first_name, :email

  before_save :assign_role

  def assign_role
    self.role = 'Regular' if self.role.nil?
  end

  def admin?
    self.role == 'Admin' if self.role
  end
end
