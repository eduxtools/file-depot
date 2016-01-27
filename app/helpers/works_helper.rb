module WorksHelper
  def file_icon(content_type, html_options={})
    image_tag(file_icon_path(content_type), html_options)
  end

  def file_icon_path(content_type)
    case content_type
    when "application/x-shockwave-flash"
      'icons/Adobe_Flash.png'
    when "application/postscript"
      'icons/Adobe_Illustrator.png'
    when "application/pdf"
      'icons/File_Pdf.png'
    when "application/msword"
      'icons/Word.png'
    when "application/vnd.openxmlformats-officedocument.wordprocessingml.document"
      'icons/Word.png'
    when "text/php"
      'icons/Adobe_Dreamweaver.png'
    # when "text/html"
    #   'icons/Adobe_Dreamweaver.png'
    when "application/octet-stream" # seems to be attached to Word documents that were uploaded to Blackboard
      'icons/News.png'
    when /^text/
      'icons/News.png'
    when /^audio/
      'icons/Audio.png'
    when /^video/
      'icons/Video.png'
    when '/^image/'
      'icons/Image.png'
    else
      'icons/File.png'
    end
  end

end