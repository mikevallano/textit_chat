json.array!(@consultation_questions) do |consultation_question|
  json.extract! consultation_question, :id, :preview, :question
  json.url consultation_question_url(consultation_question, format: :json)
end
