module LenovoSupport
  class ProductParser
    def initialize(serial)
      @data = LenovoSupport::Base.get_request("Product/#{serial}")
    end

    def data
      @data
    end

    def to_h
      {
          :serial => serial,
          :label => label,
          :machine_type => machine_type,
          :model => model,
          :in_warranty => in_warranty,
          :purchased_text => purchased_text,
          :warranty_description => warranty_description,
      }
    end



    def serial
      id_parts[-1]
    end

    def label
      (@data["Name"].split(" "))[0]
    end

    def machine_type
      mtm[0,4]
    end

    def model
      mtm[4..-1]
    end

    def mtm
      id_parts[-2]
    end

    def in_warranty
      @data["InWarranty"]
    end

    def purchased_text
      @data["Purchased"]
    end

    def warranty_description
      text = []
      original_text = @data["Warranty"]
      original_text.each do |warranty|
        next if warranty.nil? or warranty.empty?
        text << "#{warranty.fetch('Name', '')}: #{warranty["Start"].split("T00")[0]} - #{warranty["End"].split("T00")[0]}"
      end
      # end
      text
    end


    private

    def id_parts
      @data["ID"].split("/")
    end
  end
end