class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  has_many :clients, inverse_of: :user

  def name
    self.first_name + " " + self.last_name
  end

  def self.from_api_key(api_key)
    token_data = JsonWebToken.decode(api_key)

    if token_data.nil?
      return nil, "Invalid JWT token", :unauthorized
    else
      user = User.where(id: token_data["user_id"]).first
    end

    if user.present?
      return user, nil, 200
    else
      return nil, "Invalid user token", :bad_request
    end
  end
end
