class HomeController < ApplicationController
  def index
    star = params[:star]
    values = %w[a b c d e f g h i j k l m n o p q r s t u v w x y z]
    session[:index] ||= 0
    render text: values[session[:index]]
    if session[:index] < values.count-1
      session[:index] += 1
    else
      session[:index] = 0
    end
  end
end
