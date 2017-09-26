module InputHelper

  def unsorted_grouped_options_for_select(grouped_options, selected_key = nil, prompt = nil)
    body = ''
    body << content_tag(:option, prompt, { :value => "" }, true) if prompt

    ##Remove sort
    #grouped_options = grouped_options.sort if grouped_options.is_a?(Hash)

    grouped_options.each do |group|
      body << content_tag(:optgroup, options_for_select(group[1], selected_key), :label => group[0])
    end

    body.html_safe
  end

  def build_label_for_bar(f, method, options={})
    label = options[:label]

    if label == true
      f.label method, class: "#{'required' if options[:required] == true}"
    elsif label == :match
      f.label method, '&nbsp;'.html_safe, class: "hide-for-small-only #{'required' if options[:required] == true}"
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
      label_tag method, method.to_s.titleize, class: "#{'required' if options[:required] == true}"
     elsif label == :match
      label_tag method, '&nbsp;'.html_safe, class: "hide-for-small-only #{'required' if options[:required] == true}"
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
    content_tag :div, class: "input-wrapper #{'with-icon' unless options[:fa_icon].blank?} #{options[:wrapper_class]}", id: options[:wrapper_id], 'data-overlay-label' => options[:overlay_label] do
      concat build_label_for_bar(form_object, method, options)
      concat fa_icon options[:fa_icon] unless options[:fa_icon].blank?
      options.delete(:required) # this removed required as input tag attribute, but still uses it in the label class
      concat form_object.text_field(method, options)
      concat build_bar
    end
  end

  def text_field_tag_with_bar(method, value=nil, options = {})
    content_tag :div, class: "input-wrapper #{'with-icon' unless options[:fa_icon].blank?} #{options[:wrapper_class]}", id: options[:wrapper_id], 'data-overlay-label' => options[:overlay_label] do
      concat build_label_tag_for_bar(method, options)
      options.delete(:required) # this removed required as input tag attribute, but still uses it in the label class
      concat text_field_tag(method, value, options)
      concat fa_icon options[:fa_icon] unless options[:fa_icon].blank?
      concat build_bar
    end
  end

  def datepicker_with_bar(form_object, method, options = {})
    options = {class: '', placeholder: 'mm/dd/yyyy', value: (form_object.object.send(method).to_s(:date_slashed_full) rescue '')}.merge(options)
    options[:class] = 'datepicker ' + options[:class].to_s

    text_field_with_bar(form_object, method, options)
  end

  def datepicker_tag_with_bar(method, value=params[method], options = {})
    text_field_tag_with_bar(method, (value.to_s(:date_slashed_full) rescue value), options.merge({class: 'datepicker', placeholder: 'mm/dd/yyyy'}))
  end

  def password_field_with_bar(form_object, method, options = {})
    content_tag :div, class: "input-wrapper #{options[:wrapper_class]}", id: options[:wrapper_id], 'data-overlay-label' => options[:overlay_label] do
      concat build_label_for_bar(form_object, method, options)
      concat form_object.password_field(method, options)
      concat build_bar
    end
  end

  def password_field_tag_with_bar(method, value = nil, options = {})
    content_tag :div, class: "input-wrapper #{options[:wrapper_class]}", id: options[:wrapper_id], 'data-overlay-label' => options[:overlay_label] do
      concat build_label_tag_for_bar(method, options)
      options.delete(:required) # this removed required as input tag attribute, but still uses it in the label class
      concat password_field_tag(method, value, options)
      concat build_bar
    end
  end

  def text_area_with_bar(form_object, method, options = {})
    options = {rows: 7}.merge(options) # default row count is 7

    content_tag :div, class: "input-wrapper #{options[:wrapper_class]}", id: options[:wrapper_id], 'data-overlay-label' => options[:overlay_label] do
      concat build_label_for_bar(form_object, method, options)
      options.delete(:required) # this removed required as input tag attribute, but still uses it in the label class
      concat form_object.text_area(method, options)
      concat build_bar
    end
  end

  def text_area_tag_with_bar(method, value, options = {})
    options = {rows: 7}.merge(options) # default row count is 7

    content_tag :div, class: "input-wrapper #{options[:wrapper_class]}", id: options[:wrapper_id], 'data-overlay-label' => options[:overlay_label] do
      concat build_label_tag_for_bar(method, options)
      options.delete(:required) # this removed required as input tag attribute, but still uses it in the label class
      concat text_area_tag(method, value, options)
      concat build_bar
    end
  end

  # NOTE accepts all the same options as check_box, but adds the inverted option to invert the toggle states
  def toggle_check_box(form_object, method, options = {}, checked_value = 'true', unchecked_value = 'false')
    content_tag :label, class: "input-toggle #{'inverted' if options[:inverted]} #{options[:wrapper_class]}", id: options[:wrapper_id] do
      options.delete(:inverted)
      concat form_object.check_box method, options, checked_value, unchecked_value
      concat content_tag :span, '', class: 'slider'
    end
  end

  # NOTE accepts all the same options as check_box_tag, but adds the inverted option to invert the toggle states
  def toggle_check_box_tag(name, value = 'true', checked = false, options = {})
    content_tag :label, class: "input-toggle #{'inverted' if options[:inverted]} #{options[:wrapper_class]}", id: options[:wrapper_id] do
      options.delete(:inverted)
      concat check_box_tag name, value, checked, options
      concat content_tag :span, '', class: 'slider'
    end
  end

  # NOTE accepts all the same options as link_to, but adds the inverted option to invert the toggle states
  def toggle_link_to(*args, &block)
    #code
  end

  def chosen_select(form_object, method, choices=nil, options={}, html_options={})
    html_options = {class: 'chosen'}.merge(html_options)
    html_options[:class] = 'chosen ' + html_options[:class].to_s
    html_options[:id] = html_options[:id] if html_options[:id]

    content_tag :div, class: "input-wrapper chosen-wrapper #{options[:wrapper_class]}", id: options[:wrapper_id], 'data-overlay-label' => options[:overlay_label] do
      concat build_label_for_bar(form_object, method, options)
      options.delete(:required)       # this removed required as input tag attribute, but still uses it in the label class
      html_options.delete(:required)  # this removed required as input tag attribute, but still uses it in the label class
      concat form_object.select(method, choices, options, html_options)
      concat build_bar
    end
  end

  def chosen_select_tag(name, choices=nil, options={})
    options = {class: 'chosen'}.merge(options)
    options[:class] = 'chosen ' + options[:class].to_s
    options[:id] = options[:id] if options[:id]

    content_tag :div, class: "input-wrapper chosen-wrapper #{options[:wrapper_class]}", id: options[:wrapper_id], 'data-overlay-label' => options[:overlay_label] do
      concat build_label_tag_for_bar(name, options)
      options.delete(:required) # this removed required as input tag attribute, but still uses it in the label class
      concat select_tag(name, choices, options)
      concat build_bar
    end
  end

  def chosen_select_currency(form_object, method, options={}, html_options={})
    chosen_select(form_object, method, options_for_select(AppConfig['currency_options'], form_object.object.send(method)), options, html_options)
  end

  def chosen_select_year(form_object, method, choices=nil, options={}, html_options={})
    if options.blank?
      selected_year = form_object.object.date.to_s(:year).to_i rescue nil
      min_year = 1990 # 20.years.ago.year
      # min_year = (selected_year && min_year > selected_year) ? (selected_year - 2) : 20.years.ago.year
      max_year = 5.years.from_now.year
      # max_year = (selected_year && max_year < selected_year) ? (selected_year + 2) : 5.years.from_now.year

      choices = (min_year..max_year).to_a.reverse
    end

    chosen_select(form_object, method, choices, options.merge({selected: selected_year, wrapper_class: 'without-search input-wrapper-year'}), {data: {placeholder: 'Year'}})
  end

  def chosen_select_quarter(form_object, method, choices=nil, options={}, html_options={})
    # This uses the chosen_select_month helper, but only returns 4 'months' (using beginning of month by default—end of month would also require a different day of the month field)
    choices = [['Q1', 1], ['Q2', 4], ['Q3', 7], ['Q4', 10]] if choices.nil?
    chosen_select_month(form_object, method, choices, options.merge({wrapper_class: 'input-wrapper-quarter'}), html_options.merge({data: {placeholder: 'Quarter'}}))
  end

  def chosen_select_month(form_object, method, choices=nil, options={}, html_options={})
    choices = Date::MONTHNAMES.each_with_index.collect{|m, i| [m, i]} if choices.nil?
    chosen_select(form_object, method, choices, options.merge({selected: (form_object.object.date.strftime("%-m") rescue nil), wrapper_class: 'without-search input-wrapper-month'}), data: {placeholder: 'Month'})
  end

  def chosen_select_week(form_object, method, choices=nil, options={}, html_options={})
    choices = (1..52).to_a.map{|w| ["Wk #{w}", w]} if choices.nil?
    chosen_select(form_object, method, choices, options.merge({selected: (form_object.object.date.strftime("%V").to_i rescue nil), wrapper_class: 'without-search input-wrapper-week'}), data: {placeholder: 'Week'})
  end

end
