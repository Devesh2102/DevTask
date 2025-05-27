class Project < ApplicationRecord
  belongs_to :user, class_name: "User"
  has_many :project_memberships, dependent: :destroy
  has_many :users, through: :project_memberships
  has_many :tasks, dependent: :destroy
  validates :name, :deadline, presence: true
end
