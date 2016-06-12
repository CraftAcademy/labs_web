module ImageHelper
  CDN_URL = 'https://assets.craftacademy.se'

  def image_path(path)
    "#{CDN_URL}/images/#{path}"
  end
end
