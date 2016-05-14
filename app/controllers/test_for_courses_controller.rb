class TestForCoursesController < ApplicationController
  def create
    if current_user.type == "Teacher"
      @course = Course.find_by(id: params[:course_id])
      @test = Test.find_by(id: params[:test_id])
      if !@course.nil? && !@test.nil? && @test.teacher_id == current_user.id && @course.teacher_id == current_user.id
        @test.add_course(@course)
      end
    end
    respond_to do |format|
      format.html {redirect_to @course}
      format.js
    end
  end

  def destroy
    test_for_course = TestForCourse.find(params[:id])
    if !test_for_course.nil? && current_user.type == "Teacher"
      @test = test_for_course.test
      @course = test_for_course.course
      if @test.is_test_in_course?(@course) && @course.teacher_id == current_user.id
        @test.remove_course(@course)
      end
    else
      redirect_to courses_path
    end
    respond_to do |format|
      format.html {redirect_to @course}
      format.js
    end
  end
end
