class User < ApplicationRecord
  has_many :project_memberships
  has_many :projects, through: :project_memberships
  has_many :projects_created, class_name: "Project", foreign_key: "user_id"

  has_many :assigned_tasks, class_name: 'Task', foreign_key: 'assigned_to'
  has_many :comments

  enum role: { admin: 'admin', manager: 'manager', member: 'member' }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
