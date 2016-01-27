# -------------------------------------------------
# This is the raw script to update the previous 
# legacy models (using attachment_fu) to paperclip
# -------------------------------------------------

# Move images to attachments
Legacy::Image.where(parent_id: nil).each do |image|
  work = image.work
  if work
    attachment = work.attachments.create(file: File.new("#{Rails.root}/public#{image.public_filename}", 'r'))
  end
end

# Move other_files to attachments
Legacy::OtherFile.where(parent_id: nil).each do |other_file|
  work = other_file.work
  if work
    attachment = work.attachments.create(file: File.new("#{Rails.root}/public#{other_file.public_filename}", 'r'))
  end
end

# Move SyllabusFiles to Syllabi
# ---- Untested -----
Legacy::SyllabusFile.each do |legacy_syllabus|
  syllabus = Syllabus.new

  syllabus.term           = legacy_syllabus.term
  syllabus.instructor_id  = legacy_syllabus.instructor_id
  syllabus.course_id      = legacy_syllabus.course_id
  syllabus.document       = File.new("#{Rails.root}/public#{legacy_syllabus.public_filename}", 'r')
end
