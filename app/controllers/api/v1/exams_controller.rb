module Api::V1
  class ExamsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_exam, only: [:show, :update, :destroy]
    before_action :authorize_access!, only: [:index]

    # GET /exams
    def index
      if current_user.doctor? || current_user.admin?
        @exams = Exam.all
        render json: { status: 'success', data: @exams }
      else
        render json: { status: 'error', message: 'User is not authorized to view exams' }, status: :forbidden
      end
    rescue StandardError => e
      render json: { status: 'error', message: e.message }, status: :internal_server_error
    end

    # GET /exams/1
    def show
      if current_user == @exam.doctor.user || current_user == @exam.patient.user || current_user.admin?
        render json: { status: 'success', data: @exam }
      else
        render json: { status: 'error', message: 'User is not authorized to view this exam' }, status: :forbidden
      end
    rescue ActiveRecord::RecordNotFound => e
      render json: { status: 'error', message: e.message }, status: :not_found
    rescue StandardError => e
      render json: { status: 'error', message: e.message }, status: :internal_server_error
    end

    # POST /exams
    def create
      @exam = Exam.new(exam_params)
      if @exam.save
        render json: { status: 'success', data: @exam }, status: :created
      else
        render json: { status: 'error', errors: @exam.errors.full_messages }, status: :unprocessable_entity
      end
    rescue StandardError => e
      render json: { status: 'error', message: e.message }, status: :internal_server_error
    end

    # PATCH/PUT /exams/1
    def update
      if @exam.update(exam_params)
        render json: { status: 'success', data: @exam }, status: :ok
      else
        render json: { status: 'error', errors: @exam.errors.full_messages }, status: :unprocessable_entity
      end
    rescue StandardError => e
      render json: { status: 'error', message: e.message }, status: :internal_server_error
    end

    # DELETE /exams/1
    def destroy
      @exam.destroy
      render json: { status: 'success', message: 'Exam deleted successfully' }, status: :ok
    rescue StandardError => e
      render json: { status: 'error', message: e.message }, status: :internal_server_error
    end

    private

    def set_exam
      @exam = Exam.find(params[:id])
    end

    def authorize_access!
      unless current_user.doctor? || current_user.admin?
        render json: { status: 'Unauthorized' }, status: :forbidden
      end
    end

    def exam_params
      params.require(:exam).permit(:date, :result, :patient_id, :doctor_id)
    end
  end
end
