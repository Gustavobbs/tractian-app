enum TreeNodeType { location, asset, component }

class TreeNode {
  final String id;
  final String name;
  final TreeNodeType type;
  final dynamic data;
  final List<TreeNode> children;

  TreeNode({
    required this.id,
    required this.name,
    required this.type,
    required this.data,
    this.children = const [],
  });

  TreeNode copyWith({
    List<TreeNode>? children,
  }) {
    return TreeNode(
      id: id,
      name: name,
      type: type,
      data: data,
      children: children ?? this.children,
    );
  }
}