require_relative 'p05_hash_map'

# ### Problem
# Write a method to test whether the letters forming  a string can be
# permuted to form a palindrome. For example, "edified" can be permute to form
# "deified".
#
# ### Approach
# You've probably realized that we should use a hash map here. Use the hash map
# class that you implemented! This time, when you're setting and getting, picture
# in your mind what's goin on under the hood within the hashmap.
#
# For example, whenever you set a key-value pair, picture all the specific
# processes that's happening to the inputs.

# Use a counter hash
# Keep track of the number of double letters, O(n) time
def can_string_be_palindrome?(string)
  hash = Hash.new(0)
  double_letter_count = 0

  string.chars do |char|
    hash[char] += 1
    double_letter_count += 1 if hash[char] > 1
  end

  double_letter_count == string.length / 2 ? true : false
end
