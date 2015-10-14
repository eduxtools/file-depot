json.array!(@courses) do |course|
  json.extract! course, :id, :name, :level, :number, :description, :credit_hours
  json.url course_url(course, format: :json)
end
