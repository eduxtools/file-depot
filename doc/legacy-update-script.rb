# -------------------------------------------------
# This is the raw script to update the previous 
# legacy models (using attachment_fu) to paperclip
# -------------------------------------------------

# remaining to process overnight: 1880 – 3900

directory     = Rails.root
directory     = '/Volumes/ServerRaid/WebServer/apps/nasad/'
first_work_id = 1

def process_images(first_id, last_id=first_id+100)
  count         = 0
  directory     = '/Volumes/ServerRaid/WebServer/apps/nasad/'
  
  # Move images to attachments
  Legacy::Image.where(parent_id: nil, work_id: [first_id..last_id]).each do |image|
    work = image.work
    if work
      file = File.open("#{directory}/public#{image.public_filename}", 'r')
      attachment = work.attachments.create(file: file)
      file.close

      count += 1
    end
  end

  return "#{count} images processed"
end






# Move other_files to attachments
Legacy::OtherFile.where(parent_id: nil).each do |other_file|
  work = other_file.work
  if work
    attachment = work.attachments.create(file: File.new("#{directory}/public#{other_file.public_filename}", 'r'))
  end
end

# Move SyllabusFiles to Syllabi
# ---- Untested -----
Legacy::SyllabusFile.each do |legacy_syllabus|
  syllabus = Syllabus.new

  syllabus.term           = legacy_syllabus.term
  syllabus.instructor_id  = legacy_syllabus.instructor_id
  syllabus.course_id      = legacy_syllabus.course_id
  syllabus.document       = File.new("#{directory}/public#{legacy_syllabus.public_filename}", 'r')
end
