class Client < ApplicationRecord

  before_save :set_api_key

  belongs_to :user, inverse_of: :clients

  private
  def set_api_key
    self.api_key = SecureRandom.base64(32)
  end

end
