FactoryGirl.define do
  sequence :slugname do |n|
    "abcd#{n}"
  end

  sequence :uri do |n|
    "http://example.com/resource/#{n}"
  end

  factory :slug do
    slug { generate(:slugname) }
    url  { generate(:uri) }
  end

  factory :lookup do
    slug
    referrer { generate(:uri) }
    ip_address { "10.10.4.1" }
  end
end


