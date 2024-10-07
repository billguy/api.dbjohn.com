class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  include Permalink.active_record
end
