require 'faraday'
require 'json'

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


    def self.all
      objects = []
      product_parser = ProductParser LenovoSupport::Base.get_request('Product')
      product_parser.to_h
    end

    def self.find(serial)
      response = Faraday.get("#{}")
    end
  end
end
