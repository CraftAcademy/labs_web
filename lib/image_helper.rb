module ImageHelper
  CDN_URL = 'https://assets.craftacademy.se'

  def image_path(image)
    "#{CDN_URL}/images/#{image}"
  end

  def avatar_path(image)
    "#{image}"
  end

end
