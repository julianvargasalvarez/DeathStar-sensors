class HomeController < ApplicationController
  @@teams = {
    ruby: 0,
    yii: 0,
    symfony2: 0,
    dotnet: 0,
    django: 0,
    bender: 0
  }
  @@values ||= Sensor.get_data
  
  def index
    star = params[:star].to_sym
    response_text = "#{DateTime.now.to_s},#{@@values[@@teams[star]]}"
    puts "*" * 100
    puts @@values.length
    render text: response_text
    if @@teams[star] < @@values.count-1
      @@teams[star] += 1
    else
      @@teams[star] = 0
    end
  end
end
