module Exifable

  extend ActiveSupport::Concern

  included do

    def exif?
      return false
      exif(:exif?)
    rescue EXIFR::MalformedJPEG
      false
    end

    def date_taken
      return nil unless exif?
      exif(:date_time).try(:strftime, "%m.%d.%y %l:%M%p")
    end

    def camera_make
      exif(:make).titleize if exif?
    end

    def camera_model
      exif(:model) if exif?
    end

    def f_stop
      exif(:f_number).to_f if exif?
    end

    def exposure_time
      exif(:exposure_time).to_s if exif?
    end

    def iso
      exif(:iso_speed_ratings) if exif?
    end

    private

      def exif(arg)
        @exif ||= EXIFR::JPEG.new(photo.path)
        @exif.send(arg)
      end

  end

end
