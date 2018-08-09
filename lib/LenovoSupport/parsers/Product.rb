class ProductParser
  def initialize(data)
    @data = data
  end

  def to_h
    {
        :serial => serial,
        :name => name,
        :machine_type => machine_type,
        :model => model,
        :in_warranty => in_warranty
    }
  end

  def serial
    serial = id_parts[-1]
  end

  def name
    name_parts = @data["Name"].split(" ")
    name_parts[0]

  end

  def machine_type
    mtm[0,3]
  end

  def model
    mtm[4..-1]
  end

  def in_warranty
    true.to_s == @data["InWarranty"].downcase
  end

  private

  def id_parts
    @data["ID"].split("/")
  end

  def mtm
    id_parts[-2]
  end
end