class TextMessage < ApplicationRecord
  belongs_to :list, touch: true
end
