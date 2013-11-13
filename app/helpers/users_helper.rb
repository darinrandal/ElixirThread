module UsersHelper
  def resource_name
    :user
  end
 
  def resource
    @resource ||= User.new
  end
 
  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def current_user?(user)
    user == current_user
  end

  def user_page?(params)
    (
      params[:controller] == 'users' && 
    (
      (params[:action] == 'show' || params[:action] == 'edit') && 
      params[:id] == current_user.id.to_s
    )) || 
    (params[:controller] == 'registrations' && params[:action] == 'edit')
  end
end