# require '../LenovoSupport'
require File.expand_path('../LenovoSupport', File.dirname(__FILE__))
require 'yaml'
require 'csv'
require 'pp'
require 'json'

def save_csv(path, lines)
  CSV.open(path, "w") do |csv|
    lines.each do |line|
      csv << line
    end
  end
end

def load_csv(path)
  begin
    CSV.read(path)
  rescue Errno::ENOENT, ::IOError => e
    puts "Error reading input csv #{path}"
    []
  end
end

def get_serials(csv)
  list = []
  csv.each do |line|
    list << line[0]
  end
  list
end

def get_warranty_info(serials, csv)
  i = 0
  serials.each do |serial|
    begin
      device = ::LenovoSupport::Device.new(serial)
      warranty = device.warranty
      csv[i][1] = JSON.parse(warranty.gsub('=>', ':'))
      csv[i][2] = device.mtm
      i += 1
    rescue LenovoSupport::APIError
      puts "Serial: #{serial}"
      raise LenovoSupport::APIError
    end
  end
  csv
end

def has_adp?(warranties)
  w = warranties.select do |warranty|
    warranty["Name"] == "3Y ADI $100 Excess"
  end
  if w.length == 1
    return true
  else
    return false
  end

end

def main
  input_path = File.expand_path('../../config/input_serials.csv', File.dirname(__FILE__ ))
  output_path = File.expand_path('../../config/output_serials.csv', File.dirname(__FILE__ ))

  csv = load_csv(input_path)
  serials = get_serials(csv)
  csv = get_warranty_info(serials, csv)

  has_adp_count = 0

  csv.each do |device|
    serial = device[0]
    warranty = device[1]
    mtm = device[2]
    adp = has_adp? warranty
    puts "Device, #{serial}, #{device[2]}, has adp, #{adp}"
    # puts "#{serial}" unless adp
    if adp
      has_adp_count += 1
    end
    device[1] = adp
  end

  puts "Out of #{csv.length}. #{has_adp_count} have ADP registered"

  save_csv(output_path, csv)


end

main
