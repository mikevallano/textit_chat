json.array!(@health_problems) do |health_problem|
  json.extract! health_problem, :id, :name
  json.url health_problem_url(health_problem, format: :json)
end
