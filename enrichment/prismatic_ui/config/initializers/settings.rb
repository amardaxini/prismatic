class Settings < Settingslogic
  source File.expand_path('../../settings.yml', __FILE__)
  namespace Rails.env
end