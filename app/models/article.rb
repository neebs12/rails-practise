# this is auto-loaded in to other locations in the repo!
class Article < ApplicationRecord
  include Visible

  has_many :comments, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true, length: { minimum: 10 }

  # Now gets taken care off by the `Visible` 
  # VALID_STATUSES = ['public', 'private', 'archived']

  # validates :status, inclusion: { in: VALID_STATUSES }

  # # this method is used in template - wait - this is the model ... and the view is able to talk to this!
  # def archived?
  #   status == 'archived'
  # end
end
