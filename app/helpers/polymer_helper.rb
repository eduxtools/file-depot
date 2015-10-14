module PolymerHelper

  def button_link_to(body, path, html_options={}, polymer_options={})
    link_to path, html_options do 
      "<paper-button #{convert_options_to_polymer_options(polymer_options)}>#{body}</paper-button>".html_safe
    end
  end

  def convert_options_to_polymer_options(polymer_options)
    polymer_options.stringify_keys
    dom_options = ''
    polymer_options.each do |key, value|
      dom_options += " #{key}=\"#{value.to_s}\""
    end

    return dom_options
  end
end
