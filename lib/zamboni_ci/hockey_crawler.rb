require 'curb'
require 'nokogiri'

class HockeyCrawler

   attr_reader :username, :password, :app_id

   def initialize username, password, app_id
      @username = username
      @password = password
      @app_id   = app_id
   end

   def scrape_hockey
      
      sign_in_form_response = Curl.get("https://rink.hockeyapp.net/users/sign_in") do |http|
         http.headers['Content_Type'] = "application/x-www-form-urlencoded"
         http.headers['Accept'] = "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8"
      end

      sign_in_form_csrf_token = scrape_token(sign_in_form_response.body_str)
      un_authenticated_session_token = parse_session_cookie(sign_in_form_response.header_str)

      login_response = Curl::Easy.http_post("https://rink.hockeyapp.net/users/sign_in",
                         Curl::PostField.content('user[email]', self.username),
                         Curl::PostField.content('user[password]', self.password),
                         Curl::PostField.content('what', 'sign_in'),
                         Curl::PostField.content('commit', 'Sign In'),
                         Curl::PostField.content('authenticity_token', sign_in_form_csrf_token )) do |http|
         http.headers['Cookie'] = un_authenticated_session_token
         http.headers['Content_Type'] = "application/x-www-form-urlencoded"
         http.headers['Accept'] = "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8"
      end

      authenticated_session_token = parse_session_cookie(login_response.header_str)

      devices_page_response = Curl.get("https://rink.hockeyapp.net/manage/apps/#{app_id}/devices") do |http|
         http.headers['Cookie'] = authenticated_session_token
         http.headers['Content_Type'] = "application/x-www-form-urlencoded"
         http.headers['Accept'] = "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8"
      end

      devices_page_csrf_token = scrape_token(devices_page_response.body_str)

      exported_devices_response = Curl.post("https://rink.hockeyapp.net/manage/apps/#{app_id}/app_users/export", {:_method => "post", :authenticity_token => devices_page_csrf_token }) do |http|
         http.headers['Cookie'] = authenticated_session_token
         http.headers['Content_Type'] = "application/x-www-form-urlencoded"
         http.headers['Accept'] = "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8"
      end
      
      return exported_devices_response.body_str
   end

   def scrape_token(html)
      page = Nokogiri::HTML(html)
      token = page.at('meta[name="csrf-token"]')['content']
      return token
   end

   def parse_session_cookie(header_str)
      http_response, *http_headers = header_str.split(/[\r\n]+/).map(&:strip)
      http_headers = Hash[http_headers.flat_map{ |s| s.scan(/^(\S+): (.+)/) }]

      cookie = http_headers["Set-Cookie"]
   end
end
