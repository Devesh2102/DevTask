class Task < ApplicationRecord
  belongs_to :project
  belongs_to :assigned_user, class_name: 'User', foreign_key: 'assigned_to', optional: true

  has_many :comments
  has_many :task_dependencies
  has_many :dependencies, through: :task_dependencies, source: :depends_on_task

  enum status: { todo: 'todo', in_progress: 'in_progress', done: 'done' }
  enum priority: { low: 'low', medium: 'medium', high: 'high' }
end
