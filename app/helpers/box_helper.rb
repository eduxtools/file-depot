module BoxHelper

  #
  # @param *args Hash *optional
  # @param &block Block
  # @note the option for `append_hr` can be Boolean or String for a class (such as 'hide-for-large-up')
  #
  def box(*args, &block)
    defaults  = {class: 'box'}
    options   = args.extract_options!
    options   = defaults.merge(options)
    append_hr = options.delete(:append_hr)

    capture do
      concat content_tag(:div, capture(&block), options)
      concat content_tag(:hr, nil, class: "#{append_hr unless append_hr == true}") if append_hr
    end
  end

  #
  # @return [HTML]
  # @param *args Hash *optional
  # @param &block Block
  #
  def box_bar(*args, &block)
    defaults = {class: 'box-bar clearfix'}
    options  = args.extract_options!
    options  = defaults.merge(options)

    text = options.delete(:text)

    contents = text ? text : capture(&block)

    content_tag :div, contents, options
  end

  #
  # @param *args Hash *optional
  # @param &block Block
  #
  def box_heading(*args, &block)
    defaults = {class: 'box-header clearfix'}
    options  = args.extract_options!
    options  = defaults.merge(options)

    title = options.delete(:title)

    if title && block.nil?
      content_tag :div, options do
        content_tag :h2, title
      end

    elsif title
      content_tag :div, options do
        content_tag(:h2, title, class: 'left') +
        content_tag(:div, capture(&block), class: 'right')
      end

    else
      content_tag :div, capture(&block), options
    end
  end

  #
  # @param *args Hash *optional
  # @param &block Block
  #
  def box_body(*args, &block)
    defaults = {class: 'box-body'}
    options  = args.extract_options!
    options  = defaults.merge(options)

    content_tag :div, capture(&block), options
  end
  alias_method :box_content, :box_body
end
