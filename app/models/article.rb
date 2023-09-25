class Article < ApplicationRecord
    require 'sanitize'

    validates :title, presence: true
    validates :body, presence: true

    belongs_to :author

    before_validation :sanitize_body
    after_validation :set_slug

    def to_param
        if persisted?
            slug
        else 
            nil
        end
    end

    private

    def set_slug
        self.slug = title.to_s.parameterize
    end

    def sanitize_body
        self.body = Sanitize.fragment(body, Sanitize::Config::RELAXED)
    end
end
