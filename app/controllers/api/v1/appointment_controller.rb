module Api::V1
  class AppointmentsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_appointment, only: [:show, :update, :destroy]
    before_action :authorize_access!, only: [:index]

    # GET /appointments
    def index
      if current_user.doctor? || current_user.admin?
        @appointments = Appointment.all
        render json: { status: 'success', data: @appointments }
      else
        render json: { status: 'error', message: 'User is not authorized to view appointments' }, status: :forbidden
      end
    rescue StandardError => e
      render json: { status: 'error', message: e.message }, status: :internal_server_error
    end

    # GET /appointments/1
    def show
      if current_user == @appointment.doctor.user || current_user == @appointment.patient.user || current_user.admin?
        render json: { status: 'success', data: @appointment }
      else
        render json: { status: 'error', message: 'User is not authorized to view this appointment' }, status: :forbidden
      end
    rescue ActiveRecord::RecordNotFound => e
      render json: { status: 'error', message: e.message }, status: :not_found
    rescue StandardError => e
      render json: { status: 'error', message: e.message }, status: :internal_server_error
    end

    # POST /appointments
    def create
      @appointment = Appointment.new(appointment_params)
      if @appointment.save
        render json: { status: 'success', data: @appointment }, status: :created
      else
        render json: { status: 'error', errors: @appointment.errors.full_messages }, status: :unprocessable_entity
      end
    rescue StandardError => e
      render json: { status: 'error', message: e.message }, status: :internal_server_error
    end

    # PATCH/PUT /appointments/1
    def update
      if @appointment.update(appointment_params)
        render json: { status: 'success', data: @appointment }, status: :ok
      else
        render json: { status: 'error', errors: @appointment.errors.full_messages }, status: :unprocessable_entity
      end
    rescue StandardError => e
      render json: { status: 'error', message: e.message }, status: :internal_server_error
    end

    # DELETE /appointments/1
    def destroy
      @appointment.destroy
      render json: { status: 'success', message: 'Appointment deleted successfully' }, status: :ok
    rescue StandardError => e
      render json: { status: 'error', message: e.message }, status: :internal_server_error
    end

    private

    def set_appointment
      @appointment = Appointment.find(params[:id])
    end

    def authorize_access!
      unless current_user.doctor? || current_user.admin?
        render json: { status: 'Unauthorized' }, status: :forbidden
      end
    end

    def appointment_params
      params.require(:appointment).permit(:date, :doctor_id, :patient_id)
    end
  end
end
