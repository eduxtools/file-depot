class CustomFieldOption < ActiveRecord::Base
  belongs_to :custom_field
  before_save :default_position
  default_scope { order(position: :asc) }

  private
    def default_position
      if self.position.nil?
        self.position = CustomFieldOption.where(custom_field_id: self.custom_field_id).last.position + 1 rescue 1
      end
    end
end
