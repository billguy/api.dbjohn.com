require 'exifr/jpeg'

module ActiveStorage
  class Analyzer::ImageAnalyzer < Analyzer
    def metadata
      read_image do |image|
        if rotated_image?(image)
          { width: image.height, height: image.width }
        else
          { width: image.width, height: image.height }
        end.merge(gps_from_exif(image) || {})
      end
    rescue LoadError
      logger.info "Skipping image analysis because the mini_magick gem isn't installed"
      {}
    end

    private

    def gps_from_exif(image)
      return unless image.type == 'JPEG'

      if exif = EXIFR::JPEG.new(image.path).exif
        data = {}
        if gps = exif.fields[:gps]
          data.merge({
              latitude:  gps.fields[:gps_latitude].to_f,
              longitude: gps.fields[:gps_longitude].to_f,
              altitude:  gps.fields[:gps_altitude].to_f
          })
        end
        data.merge({
          date_taken: exif.fields[:date_time],
          make: exif.fields[:make],
          model: exif.fields[:model],
          f_number: exif.fields[:f_number],
          exposure_time: exif.fields[:exposure_time],
          iso_speed_ratings: exif.fields[:iso_speed_ratings]
        })
      end
    rescue EXIFR::MalformedImage, EXIFR::MalformedJPEG
    end
  end
end
