class ApplicationController < ActionController::Base
  protect_from_forgery

  #Remove layouts for all ajax calls
  layout proc{ |c| c.request.xhr? ? false : "application" }
end
