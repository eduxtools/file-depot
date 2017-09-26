json.array!(@submissions) do |submission|
  json.extract! submission, :id, :student_id, :work_id, :data
  json.url submission_url(submission, format: :json)
end
