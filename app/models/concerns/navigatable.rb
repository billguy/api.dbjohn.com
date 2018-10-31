module Navigatable

  extend ActiveSupport::Concern

  included do

    scope :filter_by, ->(filter=nil, published=true){
      case filter
        when /year/
          created = 1.year.ago
        when /month/
          created = 1.month.ago
        when /day/
          created = DateTime.now.beginning_of_day
        else
          created = 5.years.ago
      end
      if published
        where("#{self.table_name}.created_at > ? and #{self.table_name}.published = ?", created, published).order(created_at: :desc)
      else
        where("#{self.table_name}.created_at > ?", created).order(created_at: :desc)
      end
    }

    def first(published=true)
      self.class.where("published = ?", published).order("id ASC")
    end

    def next(published=true)
      n = self.class.where("id > ? and published = ?", id, published).order("id ASC")
      n.present? ? n : first(published)
    end

    def next_permalink(published=true)
      send(:next, published).pluck(:permalink).first
    end

    def prev(published=true)
      pr = self.class.where("id < ? and published = ?", id, published).order("id DESC")
      pr.present? ? pr : last(published)
    end

    def prev_permalink(published=true)
      prev(published).pluck(:permalink).first
    end

    def last(published=true)
      self.class.where("published = ?", published).order("id ASC")
    end

  end

end