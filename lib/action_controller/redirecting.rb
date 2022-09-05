module ActionController
  module Redirecting
    def redirect_to(path)
      response.status = 302
      response.location = "/"
      response.body = ["You are being redirected"]
    end
  end 
end
