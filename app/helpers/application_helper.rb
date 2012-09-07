module ApplicationHelper

  def flash_message_class(type)
    case type
      when :alert
        "alert alert-warning"
      when :error
        "alert alert-error"
      when :notice
        "alert alert-info"
      when :success
        "alert alert-success"
      else
        "alert #{type.to_s}"
    end
  end

end
