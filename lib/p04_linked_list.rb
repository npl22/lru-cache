require 'pry'

# Key: append to the tail

class Node
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # Make links go around current node
    @prev.next = @next if @prev
    @next.prev = @prev if @next
    # Remove links from current node
    @prev = nil
    @next = nil
  end
end

class LinkedList
  # to use each_with_index, inject, etc. after writing each method
  include Enumerable

  # Initialze an empty linked list with the head and tail attached to each other
  def initialize
    @head = Node.new(:head)
    @tail = Node.new(:tail)

    @head.prev = nil
    @head.next = @tail

    @tail.next = nil
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |node, j| return node if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  # Empty if the head and tail are connected and there are no nodes in between
  def empty?
    @head.next == @tail && @tail.prev == @head
  end

  def get(key)
  end

  def include?(key)
  end

  # Append to head of list, if empty, @tail = first = @head.prev
  def append(key, val)
    new_node = Node.new(key, val)
    # Connect new_node to last element
    new_node.prev = first
    first.next = new_node
    # Connect new_node to tail (self.last = @tail.next)
    new_node.next = @tail
    @tail.prev = new_node
  end

  def update(key, val)
  end

  def remove(key)
  end

  def each
    current_node = last
    until current_node == first
      yield(current_node)
      current_node = current_node.next
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, node| acc << "[#{node.key}, #{node.val}]" }.join(', ')
  end
end

# Testing
# load 'lib/p04_linked_list.rb'
if __FILE__ == $PROGRAM_NAME
  list = LinkedList.new
  list.append(1, 1)
  list.append(2, 2)
  list.append(3, 3)
  binding.pry
end
