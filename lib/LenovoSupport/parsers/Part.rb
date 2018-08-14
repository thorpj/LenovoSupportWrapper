module LenovoSupport
  class ProductPartsParser
    def initialize(serial)
      @data = LenovoSupport::Base.get_request("Part", {"Product" => serial})
      @parts = []
    end

    def inspect
      self.to_h
    end

    def to_s
      self.to_h.to_s
    end

    def to_h
      @parts
    end

    def parts
      unless @parts.empty?
        return @parts
      end
      @data.each do |part|
        id = part["ID"]
        if LenovoSupport::PartParser.valid_id? id
          @parts << PartParser.new(id)
        end
      end
      @parts
    end
  end

  class PartParser
    def initialize(id)
      if LenovoSupport::PartParser::valid_id? id
        @data = LenovoSupport::Base.get_request("Part", {"ID" => id})
      else
        raise LenovoSupport::InvalidIDError
      end
    end

    def parse(id)
        return LenovoSupport::PartParser.new(id)
    end

    def inspect
      self.to_h
    end

    def to_s
      self.to_h.to_s
    end

    def to_h
      {
          fru: fru,
          label: label,
          description: description,
          type: type,
          images: images,
          substitues: substitutes,
      }
    end

    def fru
      @data["ID"]
    end

    def label
      @data["Name"]
    end

    def description
      @data["Description"]
    end

    def type
      @data["Type"]
    end

    def images
      @data["Images"]
    end

    def substitutes
      @data["Substitutes"]
    end

    def self.valid_id?(id)
      id =~ /^\w{7}$/
    end
  end
end