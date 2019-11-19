class PolyTreeNode
    attr_reader :parent
    attr_accessor :value

    def initialize(value)
        @value = value
        @parent = nil
        @children = []
    end

    def parent=(parent)
        return if self.parent == parent
        self.parent.delete(self)

        @parent = parent
        self.parent.children << self unless self.parent.nil?

        self
    end

    def children
        @children.dup
    end

    def add_child(child_node)
        child_node.parent = self
    end

    def remove_child(child)
        if child && !self.children.include?(child)
        raise "no child to remove"
        end

        child.parent = nil
    end
end

  def dfs(target = nil, &prc)
    raise "Need a proc or target" if [target, prc].none?
    prc ||= Proc.new { |node| node.value == target }

    return self if prc.call(self)

    children.each do |child|
      result = child.dfs(&prc)
      return result unless result.nil?
    end

    nil
  end

  def bfs(target = nil, &prc)
    raise "Need a proc or target" if [target, prc].none?
    prc ||= Proc.new { |node| node.value == target }

    nodes = [self]
    until nodes.empty?
      node = nodes.shift

      return node if prc.call(node)
      nodes.concat(node.children)
    end

    nil
  end

  def count
    1 + children.map(&:count).inject(:+)
  end
end
