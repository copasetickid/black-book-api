[
  { full_name: "Tori Kelly",   email: "tori.kelly@example.com",   phone: "033 1234 5678"},
  { full_name: "Britney Spears", email: "britney.spearsth@example.com", phone: "034 6789 1234"},
  { full_name: "Chris Brown",  email: "chris.brown@example.com",  phone: "033 4321 9876"},
  { full_name: "Jesse McCartney", email: "jesse.mccartney@example.com", phone: "034 9876 1234"},
  { full_name: "Miley Cyrus",   email: "miley.cyrus@example.com",   phone: "033 6789 4321"}
].each do |person_attributes|
  Person.create(person_attributes)
end

User.create(email: "admin@example.com", password: "password")