class HealthProblemsController < ApplicationController
  before_action :set_health_problem, only: [:show, :edit, :update, :destroy]

  respond_to :html
  layout 'navbar_only'

  def index
    @health_problems = HealthProblem.all
    respond_with(@health_problems)
  end

  def show
    respond_with(@health_problem)
  end

  def new
    @health_problem = HealthProblem.new
    respond_with(@health_problem)
  end

  def edit
  end

  def create
    @health_problem = HealthProblem.new(health_problem_params)
    @health_problem.save
    respond_with(@health_problem)
  end

  def update
    @health_problem.update(health_problem_params)
    respond_with(@health_problem)
  end

  def destroy
    @health_problem.destroy
    respond_with(@health_problem)
  end

  private
    def set_health_problem
      @health_problem = HealthProblem.find(params[:id])
    end

    def health_problem_params
      params.require(:health_problem).permit(:name)
    end
end
