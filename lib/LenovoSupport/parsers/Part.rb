module LenovoSupport
  module Level
    SERIAL = 'SERIAL'
    MTM = 'MTM'
    MT = 'MT'
  end

  class ProductPartsParser
    attr_accessor :data, :serial

    def initialize(serial)
      @serial = serial
      @data = LenovoSupport::Base.get_request("Part", {"Product" => @serial})
      @parts = parts
    end

    def inspect
      self.to_s
    end

    def to_s
      "##{self.class.name}:#{self.object_id} serial:#{@serial}"
    end

    def to_h
      @parts
    end

    def mt_parts
      select_parts Level::MT
    end

    def serial_parts
      select_parts Level::SERIAL
    end

    def mtm_parts
      select_parts Level::MTM
    end

    def compatible_parts
      combined = serial_parts + mtm_parts
      combined.uniq { |part| part.fru }
    end

    def parts
      return @parts unless @parts.nil?
      @data.map { |part| Part.new(part) if part["Name"] != ""}.compact
    end

    def select_parts(level)
      parts.select { |part| part.level == level}
    end

    def self.find_part(id)
      @parts[id]
    end
  end

  class Part
    attr_reader :fru, :category, :name, :level

    def initialize(hash)
      @fru = hash["ID"]
      @category = hash["Type"]
      @name = hash["Name"]
      @level = hash["Level"]
    end

    def to_h
      {
          fru: @fru,
          category: @category,
          name: @name,
          level: @level
      }
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
          # images: images,
          # substitues: substitutes,
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