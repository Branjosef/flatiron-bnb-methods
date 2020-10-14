class Neighborhood < ActiveRecord::Base
  belongs_to :city
  has_many :listings


  def neighborhood_openings(check_in, check_out)
    check_in = Date.strptime(check_in, '%Y-%m-%d')
    check_out = Date.strptime(check_out, '%Y-%m-%d')
    self.listings.select do |listing|
      listing.is_available?(check_in, check_out)
    end
  end

  def self.highest_ratio_res_to_listings
    self.all.max_by{|neighborhood| neighborhood.listings.length > 0 ? (neighborhood.total_reservations / neighborhood.listings.length) : 0 }
  end

  def self.most_res
    self.all.max_by{|neighborhood| neighborhood.total_reservations}
  end

  def total_reservations
    self.listings.sum{|listing| listing.reservations.length}
  end

end
