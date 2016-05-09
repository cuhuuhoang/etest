module TeachesHelper
  def opposite_type
    if current_user.type == "Teacher"
      'học viên'
    else
      'giáo viên'
    end
  end

end
