require 'pp'

module LenovoSupport
  class Device
    def initialize(serial)
      @product_parser = ProductParser.new(serial)
      @product_parts_parser = ProductPartsParser.new(serial)
      @content_parser = ContentParser.new(serial)

    end

    def to_s
      "#{label} #{serial} #{mtm} #{in_warranty} #{warranty}"
    end

    def inspect
      to_s
    end

    def serial
      @product_parser.serial
    end

    def label
      @product_parser.label
    end

    def machine_type
      @product_parser.machine_type
    end

    def model
      @product_parser.model
    end

    def mtm
      @product_parser.mtm
    end

    def in_warranty
      if @product_parser.in_warranty
        "In warranty"
      else
        "Out of warranty"
      end
    end

    def purchased
      @product_parser.purchased_text
    end

    def warranty
      @product_parser.warranty_info
    end

    def fru
      @product_parts_parser.fru
    end

    def name
      @product_parts_parser.name
    end

    def description
      @product_parts_parser.description
    end

    def type
      @product_parts_parser.type
    end

    def images
      @product_parts_parser.images
    end

    def substitutes
      @product_parts_parser.substitutes
    end

    def drivers
      @content_parser.drivers
    end

    def manuals
      @content_parser.manuals
    end


  end
end
