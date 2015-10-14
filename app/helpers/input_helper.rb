module InputHelper

  def text_field_with_bar(form_object, method, options = {})
    content_tag :div, class: "input-wrapper #{options[:wrapper_class]}", id: options[:wrapper_id], 'data-overlay-label' => options[:overlay_label] do 
      if options[:label] == true
        label_html = form_object.label(method, class: "#{'required' if options[:required] == true}")
      elsif options[:label]
        label_html = form_object.label(method, options[:label].html_safe, class: "#{'required' if options[:required] == true}") 
      else
        label_html = ''.html_safe
      end

      label_html +
      form_object.text_field(method, options) + 
      content_tag(:span, '', class: 'bar')
    end
  end

  def text_area_with_bar(form_object, method, options = {})
    options = {rows: 7}.merge(options) # default row count is 7

    content_tag :div, class: "input-wrapper #{options[:wrapper_class]}", id: options[:wrapper_id], 'data-overlay-label' => options[:overlay_label] do 
      if options[:label] == true
        label_html = form_object.label(method)
      elsif options[:label]
        label_html = form_object.label(method, options[:label].html_safe) 
      else
        label_html = ''.html_safe
      end

      label_html +
      form_object.text_area(method, options) + 
      content_tag(:span, '', class: 'bar')
    end
  end

  # this isn't dry because it is similar to text_field_with_bar
  def chosen_select(form_object, method, choices=nil, options={}, html_options={})
    content_tag :div, class: "input-wrapper chosen-wrapper #{options[:wrapper_class]}", id: options[:wrapper_id], 'data-overlay-label' => options[:overlay_label] do 
      if options[:label] == true
        label_html = form_object.label(method)
      elsif options[:label]
        label_html = form_object.label(method, options[:label].html_safe) 
      else
        label_html = ''.html_safe
      end
      html_options[:class] = 'chosen ' + html_options[:class].to_s

      label_html +
      form_object.select(method, choices, options, html_options) + 
      content_tag(:span, '', class: 'bar')
    end
  end
end