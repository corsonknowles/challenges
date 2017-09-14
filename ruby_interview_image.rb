# Find a square of 0's on a background of ones

def locator(image)
  top_left_corner = nil
  width = 0
  height = 0
  image.each_with_index do |e, i|
    unless top_left_corner
      e.each_with_index do |e2, i2|
        top_left_corner = [i, i2] if e2.zero? && !top_left_corner
        if top_left_corner && top_left_corner.first == i
          width += 1 if e2.zero?
        elsif top_left_corner && i > top_left_corner.first
          next
        end
      end
    end
    height += 1 if top_left_corner && e[top_left_corner.last].zero?
  end
  p [top_left_corner, width, height]
  [top_left_corner, width, height]
end

# Runs in O(n) time with O(1) space

# Note: This could also be written very simply with Reduce and counting the shorter dimensions, but the time complexity would remain the same, space complexity would be length + width, which is 0(n) in worst case when either length or width is 1.

# Now do it for multiple rectangles of zeroes on a background of 1's

def locator2(image)
  result = []
  how_wide = image.first.length
  how_long = image.length

  image.each_with_index do |e, i|
    e.each_with_index do |e2, i2|
      next unless e2.zero? && no_overlaps?(result, i, i2)
      answer = {
        corner: [i, i2],
        height: 1,
        width: 1
      }
      result << answer

      lookahead = i2 + 1
      until lookahead >= how_wide || e[lookahead] == 1
        answer[:width] += 1
        lookahead += 1
      end

      lookdown = i + 1
      until lookdown >= how_long || image[lookdown][i2] == 1
        answer[:height] += 1
        lookdown += 1
      end
    end
  end
  p result
  result
end

def no_overlaps?(result, i, i2)
  result.none? do |entry|
    top = entry[:corner][0]
    hgt = entry[:height]
    left = entry[:corner][1]
    wid = entry[:width]
    condition1 = (top...(top + hgt)).cover?(i)
    condition2 = (left...(left + wid)).cover?(i2)
    condition1 && condition2
  end
end

# use of the Range#cover method keeps this in O(n) time since it is constant
# with respect to the range length
# Ruby's garbage collector handles the memory allocation for each call of
# #no_overlaps?, which keeps the space usage constant, otherwise space would
# scale with the number of 0's encountered

# runs in O(n) time with O(n) space -- because the results array can
# potentially scale with n if there are enough results: consider the case of an
# alternating matrix of 0's and 1's, which will have ~ n / 2 entries.



image = [
  [1, 1, 1, 1, 1, 1, 1],
  [1, 1, 1, 1, 1, 1, 1],
  [1, 1, 1, 0, 0, 0, 1],
  [1, 1, 1, 0, 0, 0, 1],
  [1, 1, 1, 1, 1, 1, 1]
]

image2 = [
  [0, 0, 0],
  [0, 0, 0],
  [0, 0, 0]
]

image3 = [
  [0, 0, 1],
  [0, 0, 1],
  [1, 1, 1]
]

image4 = [
  [0]
]

imageQ2 = [
  [1, 1, 1, 1, 1, 1, 1],
  [1, 1, 1, 1, 1, 1, 1],
  [1, 1, 1, 0, 0, 0, 1],
  [1, 0, 1, 0, 0, 0, 1],
  [1, 0, 1, 1, 1, 1, 1],
  [1, 0, 1, 0, 0, 1, 1],
  [1, 1, 1, 0, 0, 1, 1],
  [1, 1, 1, 1, 1, 1, 1]
]

four_corners = [
  [0, 1, 1, 1, 1, 1, 0],
  [1, 1, 1, 1, 1, 1, 1],
  [1, 1, 1, 1, 1, 1, 1],
  [1, 1, 1, 1, 1, 1, 1],
  [1, 1, 1, 1, 1, 1, 1],
  [1, 1, 1, 1, 1, 1, 1],
  [1, 1, 1, 1, 1, 1, 1],
  [0, 1, 1, 1, 1, 1, 0]
]

alternating = [
  [0, 1, 0, 1, 0, 1, 0],
  [1, 0, 1, 0, 1, 0, 1],
  [0, 1, 0, 1, 0, 1, 0],
  [1, 0, 1, 0, 1, 0, 1],
  [0, 1, 0, 1, 0, 1, 0],
  [1, 0, 1, 0, 1, 0, 1],
  [0, 1, 0, 1, 0, 1, 0],
  [1, 0, 1, 0, 1, 0, 1]
]

four = [
  [0, 1],
  [1, 0]
]
eight = [
  [0, 1, 0, 1],
  [1, 0, 1, 0],
  [0, 1, 0, 1],
  [1, 0, 1, 0]
]

locator(image)
locator(image2)
locator(image3)
locator(image4)
p 'imageQ2'
p locator2(imageQ2).length
p "four_corners"
p locator2(four_corners).length
p "alternating and length"
p locator2(alternating).length
p locator2(four).length
p locator2(eight).length

# TODO: it is possible to refactor to use skip counters instead of no_overlaps
#       skips ||= 0
#       if skips > 0
#         skips -= 1
#         next
#       end
          # skips += 1
          # vertical_skips

        # result.each_with_index do |answer, ai|
        #   if answer && answer[0][1] == i && answer[3]
        #     p result[ai]
        #     result[ai][1] += 1
        #   end
        # end

      # else # e2 == 1
      #   result.each do |answer|
      #     if answer && answer[0][1] == i && answer[3]
      #       answer[3] = false
      #     end
      #   end
