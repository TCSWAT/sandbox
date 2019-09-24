class Service < ApplicationRecord

  enum service_type: [:weather, :content, :exchange]

end
