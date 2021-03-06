# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

content_types = [
  "Armorial",
  "Binder's Mark",
  "Signature",
  "Gift",
  "Monogram",
  "Shelf Mark",
  "Seller's Mark",
  "Sale Record",
  "Price/Purchase Information",
  "Colophon",
  "(De)Accession Mark",
  "Forgery/Copy",
  "Effaced",
  "Bibliographic Note"
]

content_types.each do |name|
  ContentType.find_or_create_by name: name
end

names_file = File.expand_path '../POP_Names.txt', __FILE__
if File.exists? names_file
  puts "INFO: Using names file: #{names_file}"
  File.open names_file do |f|
    numlines = f.count
    idx = 0
    f.rewind
    f.each do |name|
      Name.find_or_create_by name: name.strip
      idx += 1
      if idx % 100 == 0
        puts sprintf("INFO: %5d/%d names handled", idx, numlines)
      end
    end
    puts sprintf("INFO: %5d/%d names handled", numlines, numlines)
  end
else
  puts "WARNING: Could not find names file: #{names_file}"
end

puts "INFO: Total count of names in database: #{Name.count}"
