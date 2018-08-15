# require '../LenovoSupport'
require File.expand_path('../LenovoSupport', File.dirname(__FILE__))

class Console

  attr_reader :devices

  def initialize
    @devices = {}
  end

  def add_device(device)
    @devices[device.serial] = device
  end

  def remove_device(device)
    @devices.delete(device)
  end

  def start
    begin
      loop do
        Console.prompt
        input = gets.chomp
        command, *params = input.split /\s/

        if command =~ /\Aexit\z/i
          exit(0)
        end
        puts run(command, *params)
      end
    rescue Interrupt
      exit(0)
    end
  end

  def run(command, *params)
    if command and ::LenovoSupport::Device.instance_methods.include? command.to_sym
      serial = params[0]
      device = @devices[serial] || ::LenovoSupport::Device.new(serial)
      add_device(device)
      return device.send(command)
    else
      print "Command not found"
    end
  end

  def self.prompt
    puts "Enter <command> <serial>"
  end
end

def main
  console = Console.new

  if ARGV.empty?
    console.start
  else
    command = ARGV[0]
    *params = ARGV[1..-1]
    puts console.run(command, *params)
    exit(0)
  end
end

main