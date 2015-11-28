module MainHelper
  def user_name
    if  user_signed_in?
      return current_user.name if current_user.name
      return current_user.email
    end
    return 'Unknown'
  end
end
