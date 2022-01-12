class TextMessage < ApplicationRecord
  belongs_to :list, touch: true

  validates :content, presence: true, uniqueness: { case_sensitive: false, scope: :list }

  validate :content_one_word_and_30_chars

  # skribbl.io requirements
  def content_one_word_and_30_chars
    if content.to_s.split(' ').length > 6
      errors.add(:content, "must be 5 words or less")
    end
    if content.length > 30 || content.length < 1
      errors.add(:content, "must be less than 30 characters and not blank")
    end
  end
end
