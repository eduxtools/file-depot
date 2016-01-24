module WorksHelper
  def file_icon(content_type, html_options={})
    case content_type
	  when "application/x-shockwave-flash"
	    image_tag('icons/Adobe_Flash.png', html_options)
	  when "application/postscript"
	    image_tag('icons/Adobe_Illustrator.png', html_options)
	  when "application/pdf"
	    image_tag('icons/File_Pdf.png', html_options)
	  when "application/msword"
	    image_tag('icons/Word.png', html_options)
	  when "application/vnd.openxmlformats-officedocument.wordprocessingml.document"
	    image_tag('icons/Word.png', html_options)
		when "text/php"
	    image_tag('icons/Adobe_Dreamweaver.png', html_options)
    # when "text/html"
    #   image_tag('icons/Adobe_Dreamweaver.png', html_options)
    when "application/octet-stream" # seems to be attached to Word documents that were uploaded to Blackboard
      image_tag('icons/News.png', html_options)
		when /^text/
	    image_tag('icons/News.png', html_options)
		when /^audio/
	    image_tag('icons/Audio.png', html_options)
		when /^video/
	    image_tag('icons/Video.png', html_options)
	  else
      if content_type.to_s.include? 'image'
        image_tag('icons/Image.png', html_options)
      else
  	    image_tag('icons/File.png', html_options)
      end
	  end
  end
end