module ApplicationHelper
  def display_key(key = '')
    if(key == "error" || key == "alert")
      "danger"
    elsif (key == "notice")
      "warning";
    else
      key;
    end
  end
end
