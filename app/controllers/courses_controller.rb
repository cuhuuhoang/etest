class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :edit, :update, :destroy, :student, :test]

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
    search_string = "%#{params[:q]}%"
    in_course = params[:in_course]
    params[:page_size] = 10 if params[:page_size].nil?
    if @course.teacher_id ==current_user.id
      if in_course
        @users = @course.students.where("full_name like ? OR username like ? OR email like ?", search_string,search_string,search_string).page(params[:page]).per(params[:page_size])
      else
        @users = current_user.students_in_contact.where("full_name like ? OR username like ? OR email like ?", search_string,search_string,search_string).page(params[:page]).per(params[:page_size])
      end
    else
      redirect_to(:action => "index")
    end

    respond_to do |format|
      format.js
      format.html
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
end
