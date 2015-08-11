module ApplicationHelper

  def locale_array
    [["English", "en"], ["Zulu", "zu"], ["Xhosa", "xh"]]
  end

  def locale_array_entry_name(entry)
    entry[0]
  end

  def locale_array_entry_abbr(entry)
    entry[1]
  end

  def locale_params_for(locale_abbr, original_params)
    original_params.delete(:locale)
    original_params.merge!({locale: locale_abbr}) unless dont_append_default_locale(locale_abbr)
    return original_params
  end

private

  def  dont_append_default_locale(locale_abbr)
    is_default_locale_active? &&
    is_switching_to_default_locale(locale_abbr)
  end

  def is_switching_to_default_locale(locale_abbr)
    locale_abbr.to_s == I18n.default_locale.to_s
  end

end
