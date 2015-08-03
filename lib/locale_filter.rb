module LocaleFilter

  def self.filteredByLocale(locale)
    where(locale: locale)
  end

end