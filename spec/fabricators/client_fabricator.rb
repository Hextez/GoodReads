Fabricator(:client) do
  username {Faker::Name.name}
  email    {Faker::Internet.email}
end