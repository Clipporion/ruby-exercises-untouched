def substrings(search, dictionary)

  search = search.split

  res = dictionary.reduce(Hash.new(0)) do |acc, word|
    search.each do |searchword|
      if searchword.downcase.include?(word.downcase)
        acc[word] += 1
      end
    end
    acc
  end

  p res

end

dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit","low"]

substrings("below low",dictionary)
substrings("Howdy partner, sit down! How's it going?", dictionary)
