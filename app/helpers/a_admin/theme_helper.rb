module AAdmin::ThemeHelper
  COOKIES_THEME_KEY = 'a_admin_theme'

  def current_theme
    theme = cookies[COOKIES_THEME_KEY]
    theme ||= 'default'
    theme
  end

  def themed_asset(path)
    "/assets/themes/#{current_theme}/#{path}"
  end
end