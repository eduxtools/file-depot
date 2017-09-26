class Submission < ActiveRecord::Base
  serialize :data, Hash

  attr_accessor :temp_image_token

  belongs_to :student
  has_many :attachments, as: :parent
  accepts_nested_attributes_for :student
  validates_presence_of :student

end
