def caesar_cyper(sentence, shift_value)
  alpha_low = {}
  alpha_up = {}

  i = 0 
  ("a".."z").each do |letter|
    alpha_low[letter] = i
    i += 1
  end

  j = 0
  ("A".."Z").each do |letter|
    alpha_up[letter] = j
    j += 1
  end

  if shift_value % 26 > 0
    shift_value = shift_value % 26
  end

  shifted_alpha_low = {}
  shifted_alpha_up = {}

  i = 0
  ("a".."z").each do |letter|
    shifted_alpha_low[(i - shift_value) % 26.abs] = letter
    i += 1
  end

  j = 0
  ("A".."Z").each do |letter|
    shifted_alpha_up[(j - shift_value) % 26.abs] = letter
    j += 1
  end

sentence.split("").each do |letter|
  if letter in ("a".."z")
    print shifted_alpha_low[alpha_low[letter]]
  elsif letter in ("A".."Z")
    print shifted_alpha_up[alpha_up[letter]]
  else print letter
  end
end
print "\n"
end

puts "Please enter a sentence to encrypt:"
input = gets.chomp
puts "Please enter a shift value:"
shift = gets.chomp.to_i

caesar_cyper(input,shift)
