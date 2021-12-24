class List < ApplicationRecord
  has_and_belongs_to_many :categories
  accepts_nested_attributes_for :categories
  has_many :text_messages
  has_many :impressions, :as=>:impressionable

  def self.search(search)
    if search && search != ''
      res = self.where("title LIKE ?", "%#{search}%")
    else 
      List.all
    end
  end

  def impression_count
    impressions.size
  end

  def unique_impression_count
    # impressions.group(:ip_address).size gives => {'127.0.0.1'=>9, '0.0.0.0'=>1}
    # so getting keys from the hash and calculating the number of keys
    impressions.group(:ip_address).size.keys.length #TESTED
  end
end
