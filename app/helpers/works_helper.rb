module WorksHelper
  def file_icon(content_type)
    case content_type
	  when "application/x-shockwave-flash"
	    image_tag('icons/Adobe_Flash.png')
	  when "application/postscript"
	    image_tag('icons/Adobe_Illustrator.png')
	  when "application/pdf"
	    image_tag('icons/File_Pdf.png')
	  when "application/msword"
	    image_tag('icons/Word.png')
	  when "application/vnd.openxmlformats-officedocument.wordprocessingml.document"
	    image_tag('icons/Word.png')
		when "text/php"
	    image_tag('icons/Adobe_Dreamweaver.png')
    # when "text/html"
    #   image_tag('icons/Adobe_Dreamweaver.png')
    when "application/octet-stream" # seems to be attached to Word documents that were uploaded to Blackboard
      image_tag('icons/News.png')
		when /^text/
	    image_tag('icons/News.png')
		when /^audio/
	    image_tag('icons/Audio.png')
		when /^video/
	    image_tag('icons/Video.png')
	  else
	    image_tag('icons/File.png')
	  end
  end
end