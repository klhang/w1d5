require "byebug"

class PolyTreeNode
  attr_reader :children, :parent
  attr_accessor :value

  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end


  def parent=(node)
    # checking if self already has a parent, if so remove self from children array of old parent
    if @parent
      old_parent = @parent
      old_parent.children.delete(self)
    end

    # assning new parent to self, adding self to parent's children
    @parent = node
    node.children << self unless node.nil? # Why does this not need children in attr_accessor?

    self
  end

  def add_child(child_node)

    child_node.parent = self # parent = self

  end

  def remove_child(child_node)
    raise "Not a child" if child_node && child_node.parent != self
    child_node.parent = nil
  end

  def dfs(target)
    return self if self.value == target
    # byebug
    self.children.each do |child|
      found_node = child.dfs(target)
      return found_node unless found_node.nil?
    end

    nil
  end

  def bfs(target)
    queue = [self]

    until queue.empty?
      dequeued = queue.shift
      return dequeued if dequeued == target
      queue << self.children
    end

    nil
  end


end
