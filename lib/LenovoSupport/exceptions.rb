module LenovoSupport
  class LenovoSupportException < StandardError
    def initialize(msg='An Error Has Occurred')
      super
    end
  end

  class LenovoSupportNotFound < LenovoSupportException
  end

  class APIError < LenovoSupportException
    def initialize(errors=[])
    end
  end

  class NotFound < LenovoSupportException
  end
end
