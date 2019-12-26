Fabricator(:author) do
  name {Faker::Name.name}
  bio  {Faker::Lorem.words(number: 30)}
end