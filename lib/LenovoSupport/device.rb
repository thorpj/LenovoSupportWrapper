module LenovoSupport
  module DeviceHelpers
    def product_parser
      if defined? @product_parser and !(@product_parser.nil?)
        @product_parser
      else
        @product_parser = ProductParser.new(serial)
      end
    end

    def product_parts_parser
      if defined? @product_parts_parser and !(@product_parts_parser.nil?)
        @product_parts_parser
      else
        @product_parts_parser = ProductPartsParser.new(serial)
      end
    end

    def part_parser(id)
      if defined? @part_parser and !(@part_parser.nil?)
        @part_parser
      else
        @part_parser = PartParser.new(id)
      end
    end

    def content_parser
      if defined? @content_parser and !(@content_parser.nil?)
        @content_parser
      else
        @content_parser = ContentParser.new(serial)
      end
    end

    def to_s
      if !(serial.nil?) and !(machine_type.nil?)
        "#{serial} / #{model_name} / #{machine_type}"
      else
        model_name
      end

    end

    def to_h
      {
          serial: serial,
          model_name: model_name,
          machine_type: machine_type,
          model: model,
          mtm: mtm,
          manufacturer: "Lenovo",
          warranty_description: warranty_description,
      }
    end

    def inspect
      to_s
    end

    def model_name
      product_parser.label
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

    def warranty_description
      product_parser.warranty_description
    end

    def warranty
      warranty_description
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


  class Device
    include LenovoSupport::DeviceHelpers

    def initialize(serial)
      @serial = serial
    end

    def serial
      @serial
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

    def name
      to_s
    end
  end
end
