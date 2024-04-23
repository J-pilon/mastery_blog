class Article < ApplicationRecord
  require 'sanitize'

  enum state: { drafted: 0, published: 1 }

  belongs_to :profile
  belongs_to :category

  validates :title, presence: true
  validates :body, presence: true

  before_validation :sanitize_body
  after_validation :set_slug

  scope :published, -> { where(state: :published) }

  def to_param
    return unless persisted?

    slug
  end

  private

  def set_slug
    self.slug = title.to_s.parameterize
  end

  def sanitize_body
    sanitized = Sanitize.fragment(body, Sanitize::Config::RELAXED)
    self.body = remove_image_tags(sanitized)
  end

  def remove_image_tags(html)
    Sanitize.fragment(html, remove_contents: ['img'])
  end
end
