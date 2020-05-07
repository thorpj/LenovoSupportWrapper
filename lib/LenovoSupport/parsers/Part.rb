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
    rescue StandardError => error
      puts "#{error.inspect} #{error.message}"
      raise LenovoSupport::InvalidIDError
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
      combined.reject { |part| part.category.nil? || part.fru.nil? || part.name.nil? || part.level.nil? }
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
      "##{self.class.name}:#{self.object_id} fru:#{fru} name:#{name} category:#{category} level:#{level}"
    end

    def to_h
      {
          fru: fru,
          name: name,
          category: category,
          level: level
          # images: images,
          # substitues: substitutes,
      }
    end

    def fru
      @data["ID"]
    end

    def name
      @data["Name"]
    end

    def description
      @data["Description"]
    end

    def category
      @data["Type"]
    end

    def images
      @data["Images"]
    end

    def level
      @data["Level"]
    end

    def substitutes
      @data["Substitutes"]
    end

    def self.valid_id?(id)
      id =~ /^\w{7}$/
    end
  end
end