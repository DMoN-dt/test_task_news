class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  Time::DATE_FORMATS[:input_datestr] = '%Y-%m-%dT%H:%M%:z'
end
