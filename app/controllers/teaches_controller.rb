class TeachesController < ApplicationController

  def index(page_size: 10)
    search_string = "%#{params[:q]}%"
    types = %w(in_contact requested unaccepted)
    params[:type] = types[2] unless types.include? params[:type].to_s

    if current_user.type == "Teacher"
      method = "students_#{params[:type]}"
      @users = current_user.try(method.to_sym).where("full_name like ? OR username like ? OR email like ?", search_string,search_string,search_string).page(params[:page]).per(page_size)
    else
      method = "teachers_#{params[:type]}"
      @users = current_user.try(method.to_sym).where("full_name like ? OR username like ? OR email like ?", search_string,search_string,search_string).page(params[:page]).per(page_size)
    end



    respond_to do |format|
      format.js
      format.html
    end
  end

  def search(page_size: 10)
    search_string = "%#{params[:q]}%"
    if current_user.type == "Teacher"
      @users = Student.where("full_name like ? OR username like ? OR email like ?", search_string,search_string,search_string).page(params[:page]).per(page_size)
    else
      @users = Teacher.where("full_name like ? OR username like ? OR email like ?", search_string,search_string,search_string).page(params[:page]).per(page_size)
    end

    respond_to do |format|
      format.js
      format.html
    end
  end

  def create
    if current_user.type == "Teacher"
      @user = User.find(params[:student_id])
      if @user.type == "Student"
        current_user.teach(@user)
      end
    elsif current_user.type == "Student"
      @user = User.find(params[:teacher_id])
      if @user  .type == "Teacher"
        current_user.learn(@user)
      end
    end
    respond_to do |format|
      format.html {redirect_to index}
      format.js
    end
  end

  def destroy
    teach = Teach.where("id = ?",params[:id]).first
    if teach
      if current_user.type == "Teacher"
        @user = teach.student
        current_user.unteach(@user)
      elsif current_user.type == "Student"
        @user = teach.teacher
        current_user.unlearn(@user)
      end
    else
      @user = current_user
    end
    respond_to do |format|
      format.html {redirect_to index}
      format.js
    end
  end
end
