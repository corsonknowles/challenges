def firstNotRepeatingCharacter(s)
    input = hashcount2(s)
    indices = input.last
    hash = input.first
    # letters = ('a'..'z').to_a
    # letters.each do |letter|
    #     return letter if hash[letter] == 1
    # end
    nonrepeats = hash.select {|letter, value| value == 1 }
    return '_' if nonrepeats.empty?
    # order = []
    # nonrepeats.each do |letter|
    #     order << s.find_index(letter)
    # end
    # first_index = order.each_with_index.min.last
    # hash[first_index]
    indices.sort.each do |entry|
        index, letter = entry.first, entry.last
        return letter if nonrepeats.include?(letter)
    end

end

def hashcount2(string)
    result = Hash.new(0)
    indices = []
    string.split.each_with_index do |letter, index|
        result[letter] += 1
        if result[letter] == 1
            indices << [index, letter]
        end
    end
    [result, indices]
end
