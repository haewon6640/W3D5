class PolyTreeNode
    attr_reader :parent
    attr_accessor :children, :value
    def initialize(value, parent = nil, children = [])
        @parent = parent
        @children = children
        @value = value
    end
    
    def parent=(daddy)
        unless self.parent == nil
            self.parent.children.delete(self)
        end
        @parent = daddy
        daddy.children.append(self) if daddy
    end

    def add_child(child_node)
        child_node.parent = self if child_node != nil
        self.children << child_node unless self.children.include?(child_node)
    end

    def remove_child(child_node)
        unless self.children.include?(child_node)
            raise 'This child is an orphan :('
        end
        self.children.delete(child_node) 
        child_node.parent = nil
    end

    def dfs(target_value)
        return self if self.value == target_value
        self.children.each do |child|
            result = child.dfs(target_value)
            return result unless result == nil
        end
        nil
    end

    def bfs(target_value)
        queue = []
        queue << self
        while queue.length != 0
            node = queue.shift
            return node if node.value == target_value
            queue += node.children
        end
        return nil
    end
end

# a = PolyTreeNode(4)
# b = PolyTreeNode(5)
# c = PolyTreeNode(6)
# d = PolyTreeNode(7)
# e = PolyTreeNode(8,[a,b])
# f = PolyTreeNode(9,[])
