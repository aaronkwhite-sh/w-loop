module UsersHelper

  # Returns the Gravatar (http://gravatar.com/) for the given user.
  def gravatar_for(user, options = { size: 60 })
    #gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    #size = options[:size]
    #gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    #image_tag(gravatar_url, alt: user.name, class: "gravatar avatar")
    if user.avatar != nil
      user_avatar = user.avatar
      size = options[:size]
      google_prof_img = user_avatar[0..-7] + "?sz=#{size}"
      image_tag(google_prof_img, alt: user.name, class: "gravatar avatar")
    else
      gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
      size = options[:size]
      gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
      image_tag(gravatar_url, alt: user.name, class: "gravatar avatar")
    end

  end
end
