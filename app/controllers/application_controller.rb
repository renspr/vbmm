class ApplicationController < ActionController::Base
  protect_from_forgery

  def map
    authenticate_member!
    @members = Member.all
  end

private

  def current_member
    @current_member ||= Member.find(session[:member_id]) if session[:member_id]
  end
  helper_method :current_member

  def current_member?
    current_member.present?
  end
  helper_method :current_member?

  def authenticate_member!
    redirect_to new_session_path, alert: "Bitte zuerst anmelden" if current_member.nil?
  end

  def get_url(url, data = {})
    uri       = get_uri(url)
    uri.query = URI.encode_www_form(data)
    http      = get_http_connection(uri)

    request = Net::HTTP::Get.new(uri.request_uri)
    request.set_form_data(data)

    response = http.request(request)
  end

  def post_url(url, data = {})
    uri  = get_uri(url)
    http = get_http_connection(uri)

    request = Net::HTTP::Post.new(uri.request_uri)
    request.set_form_data(data)

    response = http.request(request)
  end

  def get_uri(url, params = {})
    url = "#{url}?#{params.collect{"#{k.to_s}=#{v.to_s}"}.join('&')}" if params
    URI.parse(URI.escape(url))
  end

  def get_http_connection(uri)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = (uri.scheme == 'https')
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    return http
  end

end
