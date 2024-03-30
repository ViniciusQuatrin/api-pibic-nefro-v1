class QuestionsController < ApplicationController
  # before_action :authenticate!, only: [:create]

  def index
    @questions = Question.all
    render json: @questions
  end

  def create
    @question = Question.new
    @question.attributes = question_params
    save_question!
  end

  def update
    @question.attributes = question_params
    save_question!
  end

  def destroy
    @question.destroy
  end

  def show
    @question = Question.find(params[:id])
    render json: @question
  end

  private

  def question_params
    params.require(:question).permit(:short, :title, :question)
  end

  def save_question!
    @question.save
  end
end
