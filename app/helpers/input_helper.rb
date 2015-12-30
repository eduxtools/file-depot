module InputHelper

  def build_label_for_bar(f, method, options={})
    label = options[:label]

    if label == true
      f.label method
    elsif label == :match
      f.label method, '&nbsp;'.html_safe, class: 'hide-for-small-only'
    elsif label.is_a?(String)
      f.label method, label.html_safe, class: "#{'required' if options[:required] == true}"
    else
      # no label
      ''
    end
  end

  def build_label_tag_for_bar(method, options={})
    label = options[:label]

    if label == true
      label_tag method
     elsif label == :match
      label_tag method, '&nbsp;'.html_safe, class: 'hide-for-small-only'
    elsif label.is_a?(String)
      label_tag method, label.html_safe, class: "#{'required' if options[:required] == true}"
    else
      # no label
      ''
    end
  end

  def build_bar
    content_tag :span, nil, class: 'bar'
  end

  def text_field_with_bar(form_object, method, options = {})
    content_tag :div, class: "input-wrapper #{options[:wrapper_class]}", id: options[:wrapper_id], 'data-overlay-label' => options[:overlay_label] do
      concat build_label_for_bar(form_object, method, options)
      concat form_object.text_field(method, options)
      concat build_bar
    end
  end

  def text_field_tag_with_bar(method, value, options = {})
    content_tag :div, class: "input-wrapper #{options[:wrapper_class]}", id: options[:wrapper_id], 'data-overlay-label' => options[:overlay_label] do
      concat build_label_tag_for_bar(method, options)
      concat text_field_tag(method, value, options)
      concat build_bar
    end
  end

  def password_field_tag_with_bar(method, value, options = {})
    content_tag :div, class: "input-wrapper #{options[:wrapper_class]}", id: options[:wrapper_id], 'data-overlay-label' => options[:overlay_label] do
      concat build_label_tag_for_bar(method, options)
      concat password_field_tag(method, value, options)
      concat build_bar
    end
  end

  def text_area_with_bar(form_object, method, options = {})
    options = {rows: 7}.merge(options) # default row count is 7

    content_tag :div, class: "input-wrapper #{options[:wrapper_class]}", id: options[:wrapper_id], 'data-overlay-label' => options[:overlay_label] do
      concat build_label_for_bar(form_object, method, options)
      concat form_object.text_area(method, options)
      concat build_bar
    end
  end

  def text_area_tag_with_bar(method, value, options = {})
    options = {rows: 7}.merge(options) # default row count is 7

    content_tag :div, class: "input-wrapper #{options[:wrapper_class]}", id: options[:wrapper_id], 'data-overlay-label' => options[:overlay_label] do
      concat build_label_tag_for_bar(method, options)
      concat text_area_tag(method, value, options)
      concat build_bar
    end
  end

  def chosen_select(form_object, method, choices=nil, options={}, html_options={})
    html_options = {class: 'chosen'}.merge(html_options)
    html_options[:class] = 'chosen ' + html_options[:class].to_s
    html_options[:id] = html_options[:id] if html_options[:id]

    content_tag :div, class: "input-wrapper chosen-wrapper #{options[:wrapper_class]}", id: options[:wrapper_id], 'data-overlay-label' => options[:overlay_label] do
      concat build_label_for_bar(form_object, method, options)
      concat form_object.select(method, choices, options, html_options)
      concat build_bar
    end
  end

  def chosen_select_currency(form_object, method, options={}, html_options={})
    chosen_select(form_object, method, options_for_select(AppConfig['currency_options'], form_object.object.send(method)), options, html_options)
  end

end
