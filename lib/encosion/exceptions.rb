module Encosion
  # Generic Encosion error class
  class EncosionError < StandardError
    attr :okToRetry
    def initialize message
      super(message)
      @message = message
      @okToRetry = false
    end
  end
  
  # Brightcove Media API System Error (100-199 codes)
  class BrightcoveSystemError < EncosionError
  end
  
  # 100 code
  class BrightcoveUnknownServerError < BrightcoveSystemError
  end  

  # 101 code
  class BrightcoveUnknownServerError < BrightcoveSystemError
  end
  
  # 103 code
  class BrightcoveTimeoutException < BrightcoveSystemError
    def initialize message
      super(message)
      @message = message
      @okToRetry = true
    end
  end
  
  # 200-299 codes
  class BrightcoveLowLevelException < EncosionError
  end
  
  # 300-399 codes
  class BrightcoveHighLevelException < EncosionError
  end
  
  ### Below are Exceptions that do not relate to the Media API
  
  # Raised when there is no token (required to use the Brightcove API)
  class MissingToken < EncosionError
  end
  
  # Raised when some parameter is missing that we need in order to do a search
  class AssetNotFound < EncosionError
  end
  
  # Raised when Brightcove doesn't like the call that was made for whatever reason
  class NoFile < EncosionError
  end

  # http status code errors, anything that isn't a 200
  class HttpException < EncosionError
  end

end
