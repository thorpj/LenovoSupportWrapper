module LenovoSupport
  class Device

    include ActiveAttr::Model
    include ActiveAttr::TypecastedAttributes

    attribute :serial, type: String
    attribute :name, type: String
    attribute :machine_type, type: String
    attribute :model, type: String
    attribute :in_warranty, type: Boolean

    validates :serial, presence: true
    validates :name, presence: true
    validates :machine_type, presence: true
    validates :model, presence: true
    validates :in_warranty, presence: true
    validates :shipped_text, presence: true
    validates :warranty_text, presence: true


    def initialize(serial)
      @product_parser = ProductParser.new(serial)
      @product_parts_parser = ProductPartsParser.new(serial)
      @content_parser = ContentParser.new(serial)

    end

    def serial
      @product_parser.serial
    end

    def name
      @product_parser.name
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
      @product_parser.in_warranty
    end

    def purchased
      @product_parser.purchased_text
    end

    def warranty
      @product_parser.warranty_text
    end


  end
end
