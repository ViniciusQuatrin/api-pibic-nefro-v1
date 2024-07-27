module Api::V1
  class PatientQuestionsController < ApplicationController
    before_action :authenticate_user!

    # POST /patient_questions
    def create
      @patient_question = current_user.patient.patient_questions.new(patient_question_params)
      if @patient_question.save
        render json: { status: 'success', data: @patient_question }, status: :created
      else
        render json: { status: 'error', errors: @patient_question.errors.full_messages }, status: :unprocessable_entity
      end
    end

    private

    def patient_question_params
      params.require(:patient_question).permit(:question_id, response: [])
    end
  end
end
