class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :edit, :update, :destroy, :student, :test]
  skip_before_action :verify_authenticity_token, only: [:student]
  # GET /courses
  # GET /courses.json
  def index
    search_string = "%#{params[:q]}%"
    params[:page_size] = 10 if params[:page_size].nil?
    @courses = current_user.courses.where("name like ? OR description like ?", search_string,search_string).page(params[:page]).per(params[:page_size])

    respond_to do |format|
      format.js
      format.html
    end
  end

  # GET /courses/1
  # GET /courses/1.json
  def show
  end

  # GET /courses/new
  def new
    @course = Course.new
  end

  # GET /courses/1/edit
  def edit
  end

  # POST /courses
  # POST /courses.json
  def create
    return unless current_user.type == "Teacher"
    @course = Course.new(course_params)
    @course.teacher_id = current_user.id
    respond_to do |format|
      if @course.save
        format.html { redirect_to courses_url, notice: 'Khóa học đã được tạo.' }
        format.json { render :show, status: :created, location: @course }
      else
        format.html { render :new }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /courses/1
  # PATCH/PUT /courses/1.json
  def update
    return unless current_user.id == @course.teacher_id
    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to courses_url, notice: 'Khóa học đã được cập nhật.' }
        format.json { render :show, status: :ok, location: @course }
      else
        format.html { render :edit }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/1
  # DELETE /courses/1.json
  def destroy
    @course.destroy
    respond_to do |format|
      format.html { redirect_to courses_url, notice: 'Khóa học đã bị xóa.' }
      format.json { head :no_content }
    end
  end

  def student
    student_emails = params[:student_emails]
    if !student_emails.nil?
      emails_list = student_emails.split(",").map(&:strip)
      success_email_list = []
      warning_email_list = []
      error_email_list = []
      emails_list.each do |email|
        if !is_a_valid_email?(email)
          error_email_list << email
        elsif User.exists?(email: email)
          Enroll.process_student_email(email, current_user, @course)
          warning_email_list << email
        else
          Enroll.process_student_email(email, current_user, @course)
          success_email_list << email
        end
      end
      if error_email_list.size > 0
        flash[:error] = "Những email sai format<br />"
        error_email_list.each { |email| flash[:error] << "#{email}<br />"}
      end
      if warning_email_list.size > 0
        flash[:warning] = "Những email đã có tài khoản<br />"
        warning_email_list.each { |email| flash[:warning] << "#{email}<br />"}
      end
      if success_email_list.size > 0
        flash[:success] = "Những email tạo tài khoản thành công<br />"
        success_email_list.each { |email| flash[:success] << "#{email}<br />"}
      end

    end

    params.delete :student_emails

    search_string = "%#{params[:q]}%"
    in_course = params[:in_course]
    params[:page_size] = 10 if params[:page_size].nil?
    if @course.teacher_id ==current_user.id
      if in_course
        @users = @course.students.where("full_name like ? OR email like ?", search_string,search_string).page(params[:page]).per(params[:page_size])
      else
        @users = current_user.students_in_contact.where("full_name like ? OR email like ?", search_string,search_string).page(params[:page]).per(params[:page_size])
      end
    else
      redirect_to(:action => "index")
    end

    respond_to do |format|
      format.html
      format.js
    end
  end

  def test
    search_string = "%#{params[:q]}%"
    in_course = params[:in_course]
    params[:page_size] = 10 if params[:page_size].nil?
    if @course.teacher_id ==current_user.id
      if in_course
        @tests = @course.tests.where("name like ? OR description like ?", search_string,search_string).page(params[:page]).per(params[:page_size])
      else
        @tests = current_user.tests.where("name like ? OR description like ?", search_string,search_string).page(params[:page]).per(params[:page_size])
      end
    else
      redirect_to(:action => "index")
    end

    respond_to do |format|
      format.js
      format.html
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def course_params
      params.require(:course).permit(:name, :description, :closed)
    end

    def is_a_valid_email?(email)
      (email =~ /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i)
    end
end
