class TextMessage < ApplicationRecord
  belongs_to :list, touch: true

  validate :content_one_word_and_30_chars

  # skribbl.io requirements
  def content_one_word_and_30_chars
    if content.to_s.split(' ').length > 1
      errors.add(:content, "must be one word")
    end
    if content.length > 30 || content.length < 1
      errors.add(:content, "must be less than 30 characters")
    end
  end
end
