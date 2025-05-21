class Project < ApplicationRecord
  belongs_to :user

  has_many :project_memberships
  has_many :users, through: :project_memberships

  has_many :tasks, dependent: :destroy
end
