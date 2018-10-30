module SharedScopes

  extend ActiveSupport::Concern

  included do

    scope :with_tags, -> { includes(:tag_taggings, :taggings, :tags) }
    scope :published, ->{ where(published: true ) }

  end

end
