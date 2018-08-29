
module LenovoSupport
  class Device
    def initialize(serial)
      @product_parser = nil
      @product_parts_parser = nil
      @content_parser = nil
      @part_parser = nil
      @serial = serial
    end



    def product_parser
      @product_parser || ProductParser.new(@serial)
    end

    def product_parts_parser
      @product_parts_parser || ProductPartsParser.new(@serial)
    end

    def part_parser(id)
      @part_parser = PartParser.new(id)
    end

    def content_parser
      @content_parser || ContentParser.new(@serial)
    end

    def to_s
      "#{model_name} #{serial} #{mtm} #{in_warranty} #{warranty}"
    end

    def to_h
      {
          serial: serial,
          model_name: model_name,
          machine_type: machine_type,
          model: model,
          mtm: mtm,
          manufacturer: "Lenovo",
          warranty: warranty,
      }
    end

    def inspect
      to_s
    end

    def serial
      product_parser.serial
    end

    def model_name
      product_parser.label
    end

    def machine_type
      product_parser.machine_type
    end

    def model
      product_parser.model
    end

    def mtm
      product_parser.mtm
    end

    def in_warranty
      if product_parser.in_warranty
        "In warranty"
      else
        "Out of warranty"
      end
    end

    def purchased
      product_parser.purchased_text
    end

    def warranty
      product_parser.warranty_info
    end

    def parts
      product_parts_parser.parts
    end

    def part(id)
      product_parts_parser.find_part(id)
    end

    def drivers
      content_parser.drivers
    end

    def manuals
      content_parser.manuals
    end
  end
end
