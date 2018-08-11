module LenovoSupport
  class Part
    def initialize(data)
      @data = data
    end

    def to_h
      {
          fru: fru,
          name: name,
          description: description,
          type: type,
          images: images,
          substitues: substitutes,
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

    def type
      @data["Type"]
    end

    def images
      @data["Images"]
    end

    def substitutes
      @data["Substitutes"]
    end
  end
end