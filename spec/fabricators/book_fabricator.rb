Fabricator(:book) do
  name { Faker::Lorem.words(number: 4) }
  author { Fabricate(:author) }
end