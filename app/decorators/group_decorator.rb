class GroupDecorator < Draper::Decorator
  delegate_all

  def add_group_btn(current_user)
    if current_user.admin == 1
		h.link_to "Удалить отдел", h.group_path(model), method: :delete, class: "btn btn-danger"
	end
  end

  def more_btn
  	h.link_to "Подробнее" , h.group_path(model), class: "btn btn-success"
  end

  def group_chef(g)
  	if User.where(:chef => g.id).exists?
		u = User.where(chef: g.id)
		u.last.name_user
	else
		h.content_tag(:strong, "Нет начальника")
	end
  end
  

  def del_btn_group(current_user,u)
  	if (current_user.chef == model.id && current_user.chef.present?) || current_user.admin == 1
		 h.link_to "Убрать из отдела", h.group_dell_user_path(model,user_id: u), method: :post, class: "btn btn-danger"
	end
  end

   def add_chef_btn(current_user,u)
  	if current_user.admin == 1
		 h.link_to "Сделать шефом", h.group_add_chef_path(model,user_id: u), method: :post, class: "btn btn-warning"
	end
  end

  def more_info_btn(u)
  	h.link_to "Профиль", h.user_path(u), class: "btn btn-success"
  end

  def add_to_group_btn(u)
  	h.link_to "Добавить в отдел", h.group_add_group_path(model,user_id: u), method: :post, class: "btn btn-warning"
  end

  def group_tasc_del(current_user,t)
    if current_user.chef == model.id || current_user.admin == 1
      h.link_to 'del', h.tasc_path(t, group_id: model), method: :delete, class: "btn btn-warning"
    end
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
