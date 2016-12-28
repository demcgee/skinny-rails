class Slug < ApplicationRecord

  has_many :lookups, :dependent => :destroy
  validates :given_url, presence: true, uniqueness: true
  validates :given_url, :format => { :with => URI.regexp(%w(http https)), :message => "is not a valid url" }, allow_blank: true
  validates :slug, presence: true

  def generate_slug
    self.slug = self.id.to_s(36)
    self.save
  end

  def display_slug
    ENV['BASE_URL'] + self.slug
  end
end
