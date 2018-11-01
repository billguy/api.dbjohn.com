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
      if published
        self.class.where("published = ?", published).order("id ASC").first
      else
        self.class.order("id ASC").first
      end
    end

    def next(published=true)
      published ? self.class.where("id > ? and published = ?", id, published).order("id ASC").first || first(published) : self.class.where("id > ?", id).order("id ASC").first || first(published)
    end

    def prev(published=true)
      published ? self.class.where("id < ? and published = ?", id, published).order("id DESC").first || last(published) : self.class.where("id > ?", id).order("id DESC").first || last(published)
    end

    def last(published=true)
      if published
        self.class.where("published = ?", published).order("id DESC").first
      else
        self.class.order("id DESC").first
      end
    end

    def next_permalink(published=true)
      send(:next, published).permalink
    end

    def prev_permalink(published=true)
      prev(published).permalink
    end

  end

end