json.array!(@works) do |work|
  json.extract! work, :id, :name, :term, :description, :student_id, :project_id, :instructor_id, :course_id
  json.url work_url(work, format: :json)
end
