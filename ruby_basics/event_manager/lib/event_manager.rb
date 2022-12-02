require 'csv'
require 'google/apis/civicinfo_v2'
require 'erb'

def clean_zip(zipcode)
  zipcode.to_s.rjust(5, '0')[0..4]
end

def legis_by_zipcode(zipcode)
civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
civic_info.key = 'AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw'

  begin
    civic_info.representative_info_by_address(
      address: zipcode,
      levels: 'country',
      roles: ['legislatorUpperBody', 'legislatorLowerBody']
    ).officials
  rescue
    'There are no representatives in your provided zipcode-location'
  end
end

def clean_phone_number(phone_number)
  if phone_number.length == 11 && phone_number[0] == 1
    phone_number[1..-1]
  elsif phone_number.length == 10
    phone_number
  else
    'invalid phone number'
  end
end

def regdates(file)
  file.each do |line|
    regdate = line[:regdate].split
    date = regdate[0]
    time = regdate[1]

    puts "Date: #{date} and Time: #{time}"
  end
end


puts "Event manager initialized!"

contents = CSV.open(
  'event_attendees.csv',
  headers: true,
  header_converters: :symbol
  )

def create_letter
  erb_template = ERB.new(File.read("form_letter.erb"))

  contents.each do |row|
    name = row[:first_name]

    zipcode = clean_zip(row[:zipcode])
    
    legi_name = legis_by_zipcode(zipcode)

    personal_letter = erb_template.result(binding)
    puts personal_letter
  end
end

regdates(contents)
