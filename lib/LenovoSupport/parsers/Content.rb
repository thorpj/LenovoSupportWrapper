module LenovoSupport
  class DriverParser
    def initialize(id)
      @data = LenovoSupport::Base.get("Content", {"ID" => id})
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
      files << File
    end
  end

  class FileParser
    def initialize(data)
      @data = data
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

    def operating_system
      @data["OperatingSystems"]
    end

    def url
      @data["URL"]
    end
  end

  class ManualParser
    def initialize(data)
      @data = data
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