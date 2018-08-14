class Console
  def start
    loop do
      Display.prompt
      input = gets.chomp
      command, *param = input.split /\s/

      # case command
      # when /\Adevice\z/i || /\Ad\z/i
      #
      # when /\Apart\z/i || /\Ap\z/i
      #
      # when /\Acontent\z/i || /\Ac\z/i
      #
      # when /\Adevice_parts\z/i || /\Adp\z/i
      # when /\Adevice_contents\z/i || /\Adc\z/i
      #
      #
      #
      # end


    end
  end



end

class Display
  def self.prompt

  end
end

