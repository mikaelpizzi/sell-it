class ApplicationController < ActionController::Base
    around_action :switch_locale

    def switch_locale(&action)
      I18n.with_locale(locale_from_header, &action)
    end
  
    private
  
    def locale_from_header
        accept_language = (request.env['HTTP_ACCEPT_LANGUAGE'] || 'en').scan(/^[a-z]{2}/).first
     end
end
