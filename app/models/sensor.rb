class Sensor
  def self.get_data
    rows = IO.readlines("data1000.csv")
    rows
  end

  def self.write_data
    result = []
    d = ""
    real_alert = %w[
      100 101 102 103 104 200 500 400 100 350
      100 101 102 103 104 200 500 400 100 350
      100 101 102 103 104 200 500 400 100 350
      100 101 102 103 104 200 500 400 100 350
       99  98  97  96  95  94  93  92  91  90
       89  88  87  86  85  84  93  82  81  80
    ]

    false_alert = %w[
      100 101 102 103 104 200 500 400 100 350
      100 101 102 103 104 200 500 400 100 350
      100 101 102 103 104 200 500 400 100   1
      100 101 102 103 104 200 500 400 100 350
       99  98  97  96  95  94  93  92  91  90
       89  88  87  86  85  84  93  82  81  80
    ]

    real_fail = %w[
        0   0   0   0   0   0   0   0   0   0
        0   0   0   0   0   0   0   0   0   0
        0   0   0   0   0   0   0   0   0   0
        0   0   0   0   0   0   0   0   0   0
        1   2   3   4   5   6   7   8   9  10
       11  12  13  14  15  16  17  18  19  20
    ]

    false_fail = %w[
        0   0   0   0   0   0   0   0   0   0
        0   0  20   0   0   0   0   0   0   0
        0   0   0   0   0   0   0   0   0   0
        0   0   0  30   0   0   0  11   0   0
        1   2   3   4   5   6   7   8   9  10
       11  12  13  14  15  16  17  18  19  20
    ]

    normal_measure = %w[
       80  17  90  10  11  15  23   1   3  20
       80  17  90  10  11  15  23   1   3  20
       80  17  90  10  11  15  23   1   3  20
       80  17  90  10  11  15  23   1   3  20
       80  17  90  10  11  15  23   1   3  20
       80  17  90  10  11  15  23   1   3  20
    ]

    refs = [normal_measure, false_fail, real_fail, false_alert, real_alert]
    sensors = []

    for i in 1..10000
      sensor = []
      for j in 1..5
        sensor += refs[Random.rand(5)]
      end
      sensors << sensor
    end

    result = to_records(sensors)
    f = File.open("data10000.csv", "w")
    result.each do |row|
      f.write(row+"\n")
    end
    f.close()
  end

  def self.to_records(params)
    sensors = params.length
    records = params[0].length
    result = ""
    values = []
    for i in 0...records
      for j in 0...sensors
        result += params[j][i].to_s + ","
      end
      values << result.chomp(",")
      result = ""
    end
    values
  end
end
