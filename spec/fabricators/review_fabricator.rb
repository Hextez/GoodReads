Fabricator(:review) do
  client  { Fabricator(:client) }
  book    { Fabricator(:book) }
  comment { Faker::Lorem.words(number: 25) }
end