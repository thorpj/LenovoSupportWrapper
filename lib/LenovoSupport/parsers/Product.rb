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
          :name => name,
          :machine_type => machine_type,
          :model => model,
          :in_warranty => in_warranty,
          :purchased_text => purchased_text,
          :warranty_text => warranty_text,
      }
    end

    def serial
      serial = id_parts[-1]
    end

    def name
      name_parts = @data["Name"].split(" ")
      name_parts[0]

    end

    def machine_type
      mtm[0,4]
    end

    def model
      mtm[4..-1]
    end

    def in_warranty
      @data["InWarranty"]
    end

    def purchased_text
      @data["Purchased"]
    end

    def warranty_text
      @data["Warranty"]
    end

    private

    def id_parts
      @data["ID"].split("/")
    end

    def mtm
      id_parts[-2]
    end
  end
end