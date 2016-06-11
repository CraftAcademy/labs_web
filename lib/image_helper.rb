module ImageHelper
  CDN_URL = 'https://craftacademy.github.io/craft-assets'

  def image_path(path)
    "#{CDN_URL}/images/#{path}"
  end
end
