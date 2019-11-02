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

    def to_s
      if !serial.nil? and !machine_type.nil?
        "#{serial} / #{name} / #{machine_type}"
      else
        name
      end

    end

    def serial
      serial = id_parts[-1]
    end

    def label
      name_parts = @data["Name"].split(" ")
      name_parts[0]

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
      original_text.gsub('=>', ':')
      unless original_text.blank?
        original_text.each do |warranty|
          next if warranty.blank?
          text << "#{warranty.fetch('Name', '')}: #{warranty["Start"].split("T00")[0]} - #{warranty["End"].split("T00")[0]}"
        end
      end
      text
    end

    def warranty_info
      warranty_description.to_s
    end

    private

    def id_parts
      @data["ID"].split("/")
    end
  end
end