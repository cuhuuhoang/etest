class EnrollsController < ApplicationController
  def create
    if current_user.type == "Teacher"
      @course = Course.find_by(id: params[:course_id])
      if !@course.nil? && current_user.is_student_in_contact?(params[:student_id]) && @course.teacher_id == current_user.id
        @user = User.find(params[:student_id])
        @user.enroll_course(@course)
      end
    end
    respond_to do |format|
      format.html {redirect_to @course}
      format.js
    end
  end

  def destroy
    enroll = Enroll.find(params[:id])
    redirect_to courses_path if enroll.nil?
    if !enroll.nil? && current_user.type == "Teacher"
      @user = enroll.student
      @course = enroll.course
      if current_user.is_student_in_contact?(@user.id) && @course.teacher_id == current_user.id
        @user.leave_course(@course)
      end
    end
    respond_to do |format|
      format.html {redirect_to @course}
      format.js
    end
  end
end
