class Article < ApplicationRecord
    validates :title, presence: true
    validates :body, presence: true

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
end
