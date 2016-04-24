class TeachingController < ApplicationController


  def index
    @students_in_contact = current_user.students_in_contact.page(params[:page]).per(params[:students_length].nil? ? 10: params[:students_length])
    @students_requested = current_user.students_requested.page(params[:page]).per(params[:students_length].nil? ? 10: params[:students_length])
    @students_unaccepted = current_user.students_unaccepted.page(params[:page]).per(params[:students_length].nil? ? 10: params[:students_length])
    respond_to do |format|
      format.js
      format.html
    end
  end

  def search

  end

  def teach
  end

  def study
  end

  def delete
  end
end
