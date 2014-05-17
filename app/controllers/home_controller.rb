class HomeController < ApplicationController
  @@teams = {
    felipe: 0,
    julian: 0,
    jose: 0,
    andres: 0,
    bender: 0
  }
  @@values ||= Sensor.get_data

  def index
    star = params[:star].to_sym
    response_text = @@values[@@teams[star]]
    render text: response_text
    if @@teams[star] < @@values.count-1
      @@teams[star] += 1
    else
      @@teams[star] = 0
    end
  end
end
