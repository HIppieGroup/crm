class UserDecorator < Draper::Decorator
  delegate_all

  def user_avatar
    if model.user_avatar.present?
      h.image_tag model.user_avatar, class: "img-responsive profile__image"
    else
      h.image_tag "User_gradert.png", class: "img-responsive profile__image"
    end
  end

  def user_title
    if model.name_user.present?
      model.name_user
    else
       h.content_tag(:strong, "Не установлено")
    end
  end

  def user_position
    if model.position_in_company.present?
      model.position_in_company
    else
       h.content_tag(:strong, "Не установлено")
    end
  end

  def user_group
    if model.group.present?
      model.group.group_name
    else
       h.content_tag(:strong, "Не установлено")
    end
  end

  def user_phone
    if model.phone_user.present?
      model.phone_user
    else
       h.content_tag(:strong, "Не установлено")
    end
  end

  def user_birthday
    if model.birthday_user.present?
      model.birthday_user.strftime("%d:%m:%Y")
    else
       h.content_tag(:strong, "Не установлено")
    end
  end

  def user_about
    if model.about_user.present?
      model.about_user
    else
       h.content_tag(:strong, "Не установлено")
    end
  end


  def edit_button(current_user)
    if model == current_user || current_user.admin == 1
      h.link_to 'edit', h.edit_user_path(model), class: 'btn btn-success'
    end
  end

  def add_task_btn(current_user)
    if (current_user.chef == model.group_id && current_user.chef != 0) || current_user.admin == 1
      h.link_to "Добавить Задание", h.new_user_tasc_path(model) ,class: "btn btn-success"
    end
  end

  def all_tasc_btn(current_user)
    if current_user == model || current_user.admin == 1 || (current_user.chef == model.group_id && current_user.chef != 0)
     h.link_to "Все задачи", h.user_tascs_path(model), class: "btn btn-warning"
   end
  end

  def del_user_btn(current_user)
    if current_user.admin == 1
      h.link_to 'Удалить пользователя', h.user_path(model), method: :delete, class: "btn btn-danger"
    end
  end

  def profel_btn
    h.link_to 'Профиль', h.user_path(model), class: "btn btn-success"
  end
  

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

end
