require '../LenovoSupport'

class Console
  def self.start
    devices = {}

    loop do
      Display.prompt
      input = gets.chomp
      command, *params = input.split /\s/

      if command =~ /\Aexit\z/i
        exit(0)
      end
      serial = params[0]
      device = devices[serial] || ::LenovoSupport::Device.new(serial)

      puts device.send("mtm")
      devices[device.serial] = device


      # case command
      # when /\Adevice\z/i || /\Ad\z/i
      # when /\Apart\z/i || /\Ap\z/i
      # when /\Acontent\z/i || /\Ac\z/i
      # when /\Adevice_parts\z/i || /\Adp\z/i
      # when /\Adevice_contents\z/i || /\Adc\z/i
      # end


    end
  end



end

class Display
  def self.prompt
    puts "Enter <command> <serial>"
  end
end

Console.start

