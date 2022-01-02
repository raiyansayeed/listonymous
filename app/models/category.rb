class Category < ApplicationRecord
    has_and_belongs_to_many :lists

    validates :title, uniqueness: { case_sensitive: false }
end
