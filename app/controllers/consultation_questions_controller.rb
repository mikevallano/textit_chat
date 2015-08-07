class ConsultationQuestionsController < ApplicationController
  before_action :set_consultation_question, only: [:show, :edit, :update, :destroy]

  respond_to :html

  layout "navbar_only"

  def index
    @consultation_questions = ConsultationQuestion.all
    respond_with(@consultation_questions)
  end

  def show
    respond_with(@consultation_question)
  end

  def new
    @consultation_question = ConsultationQuestion.new
    respond_with(@consultation_question)
  end

  def edit
  end

  def create
    @consultation_question = ConsultationQuestion.new(consultation_question_params)
    @consultation_question.save
    respond_with(@consultation_question)
  end

  def update
    @consultation_question.update(consultation_question_params)
    respond_with(@consultation_question)
  end

  def destroy
    @consultation_question.destroy
    respond_with(@consultation_question)
  end

  private
    def set_consultation_question
      @consultation_question = ConsultationQuestion.find(params[:id])
    end

    def consultation_question_params
      params.require(:consultation_question).permit(:preview, :question, :locale)
    end
end
