require_relative 'p02_hashing'
require_relative 'p04_linked_list'
require 'pry-byebug'

class HashMap
  include Enumerable
  attr_reader :count, :store

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    self[key] ? true : false
  end

  def set(key, val)
    resize! if @count >= num_buckets
    if include?(key)
      bucket(key).update(key, val)
    else
      bucket(key).append(key, val)
      @count += 1
    end
  end

  def get(key)
    bucket(key).get(key)
  end

  def delete(key)
    @count -= 1 if bucket(key).remove(key)
  end

  def each
    @store.each do |bucket|
      bucket.each { |node| yield([node.key, node.val]) }
    end
    nil
  end

  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  # private

  def num_buckets
    @store.length
  end

  def resize!
    old_store = @store
    @store = Array.new(num_buckets * 2) { LinkedList.new }
    @count = 0

    old_store.each do |bucket|
      bucket.each { |node| set(node.key, node.val) }
    end
  end

  def bucket(key)
    @store[key.hash % num_buckets]
  end
end

# Testing
if __FILE__ == $PROGRAM_NAME
  h = HashMap.new
  9.times { |i| h.set(i, i) }
end
