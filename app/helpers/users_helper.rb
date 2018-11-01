module UsersHelper
  
  def user_img(user)
    image_tag(user.picture.url, id: "user-icon", alt: user.name)
  end
end