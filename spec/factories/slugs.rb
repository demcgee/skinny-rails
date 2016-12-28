FactoryGirl.define do
  sequence :slugname do |n|
    "abcd#{n}"
  end

  sequence :given_url do |n|
    "http://example.com/resource/#{n}"
  end

  factory :slug do
    slug { generate(:slugname) }
    given_url  { generate(:given_url) }
  end

  factory :lookup do
    slug
    referrer { generate(:uri) }
    ip_address { "10.10.4.1" }
  end
end


