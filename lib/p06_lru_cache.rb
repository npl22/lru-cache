require_relative 'p05_hash_map'
require_relative 'p04_linked_list'
require 'pry-byebug'

class LRUCache
  attr_reader :count
  attr_reader :map, :store, :max, :prc
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    if @map[key]
      link = @map[key]
      update_link!(link)
    else
      calc!(key)
    end
  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def calc!(key)
    eject! if count == @max

    # Add new item to Linked List
    val = @prc.call(key)
    @store.append(key, val)

    # Add key to HashMap with the value being the node just appended
    @map.set(key, @store.last)

    # Return value of new item in cache
    @map[key].val
  end

  def update_link!(link)
    @store.remove(link.key)
    @store.append(link.key, link.val)
    link.val
  end

  def eject!
    @map.delete(@store.first.key)
    @store.remove(@store.first.key)
  end
end
