module Api::V1
  class QuestionsController < ApplicationController

    # GET /questions
    def index
      @questions = Question.all
      render json: { status: 'success', data: @questions }
    end

    # POST /questions
    def create
      @question = Question.new(question_params)
      if @question.save
        render json: { status: 'success', data: @question }, status: :created
      else
        render json: { status: 'error', errors: @question.errors.full_messages }, status: :unprocessable_entity
      end
    end

    private

    def question_params
      params.require(:question).permit(:title, :short, :question, :question_type)
    end
  end
end
