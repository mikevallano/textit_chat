class ConsultationQuestion < ActiveRecord::Base
  include LocaleFilter
  def to_s
    preview
  end
end
