module ApplicationHelper
  def errors_for(model, key)
    tag.div(class: "mt-2 form-error") do
      model.errors.messages_for(key).join(", ")
    end
  end
  def full_title(page_title)
    base_title = "Example Application"
    if page_title.nil? || page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end

  def bootstrap_class_for(flash_type)
    { success: "alert-success", error: "alert-danger", alert: "alert-warning",
     notice: "alert-info" }[flash_type.to_sym] || flash_type.to_s
  end

  def flash_messages(_opts = {})
    flash.each do |msg_type, message|
      concat(content_tag(:div, message, class: "alert #{bootstrap_class_for(msg_type)} alert-dismissable fade show", role: "alert") do
        concat content_tag(:button, "", class: "btn-close", data: { 'bs-dismiss': "alert" })
        concat " #{message}"
      end)
    end
    nil
  end

  def authorised
    user_signed_in?
  end
end
