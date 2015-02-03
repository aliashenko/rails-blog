class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  belongs_to :role
  has_many :posts, dependent: :destroy

  before_save :assign_role

  def assign_role
    self.role = Role.find_by name: 'Regular' if self.role.nil?
  end

  def admin?
    self.role.name == 'Admin' if self.role
  end
end
