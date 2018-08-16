# require '../LenovoSupport'
require 'clipboard'
require File.expand_path('../LenovoSupport', File.dirname(__FILE__))
require 'yaml'

class Console
  include Clipboard
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

  def write_to_file(content)
    File.open(File.expand_path('../../output.yaml', File.dirname(__FILE__)), "w") do |file|
      file.write content.to_yaml
    end
  end

  def start
    begin
      loop do
        Console.prompt
        input = gets.chomp
        command, *params = input.split /\s/
        command = command.gsub(/\s+/, "").downcase
        puts run(command, *params)
      end
    rescue Interrupt, NoMethodError
      exit(0)
    end
  end

  def run(command, *params)
    if command =~ /\Aexit\z/i
      exit(0)
    elsif command =~ /\Ahelp\z/i
      help
      exit(0)
    end

    if command and ::LenovoSupport::Device.instance_methods.include? command.to_sym
      serial = params[0]
      begin
        device = @devices[serial] || ::LenovoSupport::Device.new(serial)
        add_device(device)
      rescue LenovoSupport::APIError
        puts "Invalid id"
        return
      end
      method = device.method(command)
      arity = method.arity
      if arity > 0
        ret = device.send(command, params[1])
      else
        ret = device.send(command)
      end
      if ret.kind_of?(Array)
        new_ret = ""
        ret.each do |item|
          new_ret << item + "\n"
        end
        write_to_file(ret)
        ret = new_ret
      elsif ret.kind_of?(Hash)
        new_ret = ""
        ret.each do |key, value|
          new_ret << "#{key}: #{value}" + "\n"
        end
        write_to_file(ret)
        ret = new_ret
      end
      Clipboard.copy(ret)
      return ret
    else
      print "Command not found"
    end
  end

  def self.prompt
    puts "Enter <command> <serial>"
  end

  def help
    puts %{
= LenovoSupportConsole =

Provides a console to access information about a device


== Commands ==
Commands are not case sensitive. You must use underscores within phrases (e.g. model_name, not model name).

the field in brackets shows what id field you need to use instead of serial

* Model Name
* Machine Type
* Model
* MTM
* In Warranty
* Purchased
* Warranty
* Parts
  * fru (part_id)
  * label (part_id)
  * description (part_id)
  * type (part_id)
  * images (part_id)
  * substitutes (part_id)
* Drivers
  * Title (content_id)
  * Summary (content_id)
  * Size (content_id)
  * Type (content_id)
  * Operating Systems (content_id)
  * URL (content_id)
* Manuals
  * Title (content_id)
  * Summary (content_id)
  * Body (content_id)
  * Version (content_id)
  * File Type (content_id)
  * URL (content_id)

== Usage ==
<command> <id>

Where:
  * command is the attribute you wish to query
  * id could be a serial, fru or content id


    }
  end
end

def main
  console = Console.new

  if ARGV.empty?
    console.start
  else
    command = ARGV[0].downcase
    *params = ARGV[1..-1]
    puts console.run(command, *params)
    exit(0)
  end
end

main