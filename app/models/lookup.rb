class Lookup < ApplicationRecord
  require 'resolv'
  belongs_to :slug
  validates :slug, presence: true
  validates :ip_address, presence: true, uniqueness: true, :format => { :with => Resolv::IPv4::Regex }
  validates :referrer, presence: true, uniqueness: true
  validates :referrer, :format => { :with => URI.regexp(%w(http https)), :message => "is not a valid uri" }, allow_blank: true


end
