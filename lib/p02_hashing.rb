class Fixnum
  # Use Fixnum#hash as a base
end

class Array
  def hash
    join('').to_i.hash
  end
end

class String
  def hash
    chars.map(&:ord).hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    to_a.sort.join('').hash
  end
end
