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
    @head.next = @tail
    @tail.prev = @head
    # nil on default @head.prev = nil
    # nil on default @tail.next = nil
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
    each do |node|
      return node.val if key == node.key
    end
    nil
  end

  def include?(key)
    any? { |node| node.key == key }
  end

  # Append to head of list, if empty, @tail = first = @head.prev
  def append(key, val)
    new_node = Node.new(key, val)

    # Connect new_node to last element
    new_node.prev = last
    last.next = new_node
    # Connect new_node to tail (self.last = @tail.next)
    new_node.next = @tail
    @tail.prev = new_node

    new_node
  end

  def update(key, val)
    each do |node|
      if node.key == key
        node.val = val
        break
      end
    end
  end

  def remove(key)
    each do |node|
      if key == node.key
        node.remove
        return node.key
        break
      end
    end
  end

  def each
    current_node = first
    until current_node == @tail
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
  list.append(:first, 1)
  list.append(:second, 2)
  list.append(:third, 3)
  list.update(:second, '2nd')
  list.each { |node| puts node.key }
end
