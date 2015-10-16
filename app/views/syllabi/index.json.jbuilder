json.array!(@syllabi) do |syllabus|
  json.extract! syllabus, :id, :term, :instructor_id, :course_id
  json.url syllabus_url(syllabus, format: :json)
end
