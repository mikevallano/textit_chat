class FollowUpQuestionsController < ApplicationController
  before_action :set_follow_up_question, only: [:show, :edit, :update, :destroy]

  respond_to :html

  layout "navbar_only"

  def index
    @follow_up_questions = FollowUpQuestion.all
    respond_with(@follow_up_questions)
  end

  def show
    respond_with(@follow_up_question)
  end

  def new
    @follow_up_question = FollowUpQuestion.new
    respond_with(@follow_up_question)
  end

  def edit
  end

  def create
    @follow_up_question = FollowUpQuestion.new(follow_up_question_params)
    @follow_up_question.save
    respond_with(@follow_up_question)
  end

  def update
    @follow_up_question.update(follow_up_question_params)
    respond_with(@follow_up_question)
  end

  def destroy
    @follow_up_question.destroy
    respond_with(@follow_up_question)
  end

  private
    def set_follow_up_question
      @follow_up_question = FollowUpQuestion.find(params[:id])
    end

    def follow_up_question_params
      params.require(:follow_up_question).permit(:question)
    end
end
