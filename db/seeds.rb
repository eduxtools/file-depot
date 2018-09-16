# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


CustomField.create(name: "Grade", required: true).options.create([{name: "6"}, {name: "7"}, {name: "8"}, {name: "9"}, {name: "10"}, {name: "11"}, {name: "12"}])
CustomField.create(name: "Parent/Guardian Name(s)")
CustomField.create(name: "Address")
CustomField.create(name: "City")
CustomField.create(name: "County")
CustomField.create(name: "State").options.create([{name: "TN"}])
CustomField.create(name: "Zip")
CustomField.create(name: "Phone", required: true)
CustomField.create(name: "Teacher's Name")
CustomField.create(name: "Teacher's Phone", required: true)
CustomField.create(name: "Teacher's Email")
CustomField.create(name: "School Name")
CustomField.create(name: "School Phone")
CustomField.create(name: "Entry Title")
CustomField.create(name: "Entry Category", required: true).options.create([{name: "Painting"}, {name: "Sculpture"}, {name: "Computer Graphic"}, {name: "Drawing"}, {name: "Photograph"}, {name: "Ceramic"}, {name: "Drawing"}, {name: "Photograph"}, {name: "Ceramic"}, {name: "Video/DVD Production"}, {name: "Printmaking"}, {name: "Mixed Media"}])
CustomField.create(name: "Entry Dimensions (in inches)")
CustomField.create(name: "Optional: Artwork Description (250 characters or less)", input_type: 'textarea')
