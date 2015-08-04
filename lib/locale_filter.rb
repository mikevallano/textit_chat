module LocaleFilter
   def self.included(base)
    base.class_eval do
      scope :filtered_by_locale, -> { where(locale: I18n.locale) }
    end
  end
end