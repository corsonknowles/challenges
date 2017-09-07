def firstNotRepeatingCharacter(s)
    hash = hashcount(s)
    letters = ('a'..'z').to_a
    # letters.each do |letter|
    #     return letter if hash[letter] == 1
    # end
    nonrepeats = hash.select {|letter, value| value == 1  }
    return '_' if nonrepeats.empty?
    order = []
    nonrepeats.each do |letter|
        order << s.find_index(letter)
    end
    first_index = order.each_with_index.min.last
    hash[first_index]
end

def hashcount(string)
    result = Hash.new(0)
    string.split.each do |letter|
        result[letter] += 1
    end
    result
end
