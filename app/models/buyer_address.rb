class BuyerAddress
  include ActiveModel::Model
  attr_accessor :postal_code, :prefecture_id, :municipalities, :address, :building, :telephone_number, :user_id, :item_id, :buyer_id

  with_options presence: true do
    validates :postal_code      ,format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
    validates :prefecture_id    ,numericality: {only_integer: true}
    validates :municipalities
    validates :address
    validates :telephone_number ,numericality: {only_integer: true}
    validates :user_id
    validates :item_id
    validates :buyer_id
  end

  def save
    buyer = Buyer.create(user_id: user_id, item_id: item_id)
    Address.create(postal_code: postal_code, prefecture_id: prefecture_id, municipalities: municipalities, address: address, building: building, telephone_number: telephone_number, buyer_id: buyer.id)
  end

end