class ConsultationQuestion < ActiveRecord::Base
  def to_s
    preview
  end
end
