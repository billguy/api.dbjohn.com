class Asset < ApplicationRecord

  has_one_attached :attachment

  before_destroy :destroy_attachment

  private

    def destroy_attachment
      attachment.purge
    end

end
