module Api::V1
  class DoctorsController < ApplicationController
    before_action :authenticate_user!

    def index
      @doctors = Doctor.all
      render json: @doctors
    end

    def show
      render json: @doctor
    end

    def create
      user = User.find_by(params[:user_id])

      if user.profile == "doctor"
        @doctor = Doctor.new(doctor_params)
        if @doctor.save
          render json: { status: 'success', data: @doctor }, status: :created
        else
          render json: @doctor.errors, status: :unprocessable_entity
        end
      else
        render json: { status: 'error', message: 'User is not a doctor' }, status: :unprocessable_entity
      end
    end

    def update
      if @doctor.update(doctor_params)
        render :show
      else
        render_error
      end
    end

    def destroy
      @doctor.destroy
      head :no_content
    end

    private
    def doctor_params
      params.require(:doctor).permit(:name, :crm)
    end
  end
end
