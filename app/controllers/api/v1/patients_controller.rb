module Api::V1
  class PatientsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_patient, only: [:show, :update, :destroy, :evaluate, :evaluations]
    before_action :authorize_access!, only: [:index, :create, :update, :destroy, :evaluate, :evaluations]

    # GET /patients
    def index
      @patients = Patient.all
      render json: { status: 'success', data: @patients }
    rescue StandardError => e
      render json: { status: 'error', message: e.message }, status: :internal_server_error
    end

    # GET /patients/1
    def show
      if current_user == @patient.user || current_user.doctor? || current_user.admin?
        render json: { status: 'success', data: @patient }
      else
        render json: { status: 'error', message: 'User is not authorized to view this patient' }, status: :unprocessable_entity
      end
    rescue ActiveRecord::RecordNotFound => e
      render json: { status: 'error', message: e.message }, status: :not_found
    rescue StandardError => e
      render json: { status: 'error', message: e.message }, status: :internal_server_error
    end

    # POST /patients
    def create
      user = User.find_by(id: params[:user_id])
      if user && user.profile == "patient"
        @patient = user.build_patient(patient_params)
        @patient.user = user

        if @patient.save
          render json: { status: 'success', data: @patient }, status: :created
        else
          render json: { status: 'error', errors: @patient.errors.full_messages }, status: :unprocessable_entity
        end
      else
        render json: { status: 'error', message: 'User is not a patient or not found' }, status: :unprocessable_entity
      end
    rescue ActiveRecord::RecordNotFound => e
      render json: { status: 'error', message: e.message }, status: :not_found
    rescue StandardError => e
      render json: { status: 'error', message: e.message }, status: :internal_server_error
    end

    # PATCH/PUT /patients/1
    def update
      if @patient.update(patient_params)
        render json: { status: 'success', data: @patient }, status: :ok
      else
        render json: { status: 'error', errors: @patient.errors.full_messages }, status: :unprocessable_entity
      end
    end

    # DELETE /patients/1
    def destroy
      @patient.destroy
      render json: { status: 'success', message: 'Patient deleted' }, status: :ok
    end

    # POST /patients/1/evaluate
    def evaluate
      nefrocheck_service = NefrocheckService.new(@patient)
      result = nefrocheck_service.evaluate_and_save
      render json: result
    end

    # GET /patients/1/evaluations
    def evaluations
      evaluations = @patient.nefrocheck_evaluations
      render json: { status: 'success', data: evaluations }
    end

    private

    def set_patient
      @patient = Patient.find(params[:id])
    end

    def authorize_access!
      unless current_user.doctor? || current_user.admin?
        render json: { status: 'Unauthorized' }, status: :forbidden
      end
    end

    def patient_params
      params.require(:patient).permit(:name, :sex, :creatinine, :race, :age, :weight, :exams)
    end
  end
end
