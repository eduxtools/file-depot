class CustomField < ActiveRecord::Base
  has_many :options, class_name: 'CustomFieldOption'
  validates_presence_of :name
  before_save :default_position
  default_scope { order(position: :asc) }

  def self.fields
    return CustomField.all.map(&:name)
  end

  private
    def default_position
      if self.position.nil?
        self.position = CustomField.last.position + 1 rescue 1
      end
    end
end
