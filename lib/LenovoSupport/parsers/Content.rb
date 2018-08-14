module LenovoSupport
  class ContentParser
    def initialize(serial)
      @data = LenovoSupport::Base.get_request("Content", {"Product" => serial})
      @contents = contents
      @drivers = []
      @manuals = []
    end

    def contents
      @contents ||= {}
      unless @contents.empty?
        return @contents
      end
      LenovoSupport::config[:allowed_content].each do |path|
        @contents[path] = []
      end

      @data.each do |object|
        type = object["Type"]
        if @contents.key? type
          @contents[type] << object
        end
      end
      @contents
    end

    def drivers
      unless @drivers.empty?
        return @drivers
      end
      contents["Driver"].each do |content|
        @drivers << DriverParser.new(content["ID"])
      end
      @drivers
    end

    def manuals
      unless @manuals.empty?
        return @manuals
      end
      contents["Manual"].each do |content|
        @manuals << ManualParser.new(content["ID"])
      end
      @manuals
    end
  end

  class DriverParser
    def initialize(id)
      @data = LenovoSupport::Base.get_request("Content", {"ID" => id})
    end

    def inspect
      self.to_h
    end

    def to_s
      self.to_h.to_s
    end

    def to_h
      {
        id: id,
        released: released,
        updated: updated,
        operating_systems: operating_systems,
        title: title,
        summary: summary,
        body: body,
        files: files
      }
    end

    def id
      @data["ID"]
    end

    def released
      @data["Released"]
    end

    def updated
      @data["Updated"]
    end

    def operating_systems
      @data["OperatingSystems"]
    end

    def title
      @data["Title"]
    end

    def summary
      @data["Summary"]
    end

    def body
      @data["Body"]
    end

    def files
      files = []
      @data["Files"].each do |file|
        files << LenovoSupport::FileParser.new(file)
      end
      files
    end
  end

  class FileParser
    def initialize(data)
      @data = data
    end

    def inspect
      self.to_h
    end

    def to_s
      self.to_h.to_s
    end

    def to_h
      {
        title: title,
        summary: summary,
        size: size,
        type: type,
        operating_systems: operating_systems,
      }
    end

    def title
      @data["Title"]
    end

    def summary
      @data["Version"]
    end

    def size
      @data["Size"]
    end

    def type
      @data["Type"]
    end

    def operating_systems
      @data["OperatingSystems"]
    end

    def url
      @data["URL"]
    end
  end

  class ManualParser
    def initialize(id)
      @data = LenovoSupport::Base.get_request("Content", {"ID" => id})
    end

    def inspect
      self.to_h
    end

    def to_s
      self.to_h.to_s
    end

    def to_h
      {
        title: title,
        summary: summary,
        body: body,
        version: version,
        size: size,
        file_type: file_type,
        url: url,
      }
    end

    def title
      @data["Title"]
    end

    def summary
      @data["Summary"]
    end

    def body
      @data["Body"]
    end

    def version
      @data["Version"]
    end

    def size
      @data["Size"]
    end

    def file_type
      @data["FileType"]
    end

    def url
      @data["URL"]
    end
  end
end