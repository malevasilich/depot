require "open-uri"

module ApplicationHelper
	def hidden_div_if(condition, attributes = {}, &block)
		if condition
			attributes["style"]="display:none"
		end
		content_tag("div", attributes, &block)
	end

    GOOGLE_CURRENCY_RATE_URL="http://www.google.com/ig/calculator?hl=en&q=1USD=?KZT"
	def get_USD_to_KZT_rate
	 	if APP_CONFIG['http_proxy'].present?
			proxy = {proxy_http_basic_authentication: [APP_CONFIG['http_proxy'],
													   APP_CONFIG['http_proxy_username'],
													   APP_CONFIG['http_proxy_password']]}
		end

		j = open(GOOGLE_CURRENCY_RATE_URL, proxy).read
    	j.split("\"")[3].split(" ")[0].to_f
	end

	def get_locale_currency_rate
		return 1 if params[:locale].nil?
		params[:locale].to_sym==I18n.default_locale ? 1 : get_USD_to_KZT_rate
	end
end
