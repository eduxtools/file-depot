module SubmissionsHelper
  def categories_array(submission)
    # this is specific to mtrsae
    #
    categories = []
    categories << submission.data['Entry 1 Category'] unless submission.data['Entry 1 Category'].blank?
    categories << submission.data['Entry 2 Category'] unless submission.data['Entry 2 Category'].blank?
    return categories
  end
  def categories(submission)
    # this is specific to mtrsae
    #
    return categories_array(submission).uniq.compact.join(' & ')
  end
end
