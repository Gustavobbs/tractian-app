import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/data/models/tree_node.dart';
import 'package:flutter_application_1/src/data/models/asset.dart';

class TreeView extends StatelessWidget {
  final List<TreeNode> nodes;

  const TreeView({
    super.key,
    required this.nodes,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8),
        children: nodes.map((node) => _buildNode(context, node, 0)).toList(),
      ),
    );
  }

Widget _buildNode(BuildContext context, TreeNode node, int level) {
  final icon = _getIcon(node);
  final indent = level * 16.0;

  Widget? statusIcon;

  if ((node.type == TreeNodeType.component || node.type == TreeNodeType.asset) && node.data is Asset) {
    final Asset asset = node.data as Asset;

    if (asset.status == 'alert') {
      statusIcon = const Icon(Icons.circle, size: 14, color: Colors.red);
    } else if (asset.sensorType == 'energy') {
      statusIcon = const Icon(Icons.flash_on, size: 18, color: Colors.lightGreen);
    }
  }

  if (node.children.isEmpty) {
    return ListTile(
      contentPadding: EdgeInsets.only(left: indent, right: 8),
      leading: Icon(icon, color: Colors.blue),
      title: Text(node.name),
      trailing: statusIcon,
    );
  }

  return ExpansionTile(
    leading: Icon(icon, color: Colors.blue),
    title: Text(node.name),
    tilePadding: EdgeInsets.only(left: indent),
    shape: const RoundedRectangleBorder(side: BorderSide.none),
    children: node.children
        .map((child) => _buildNode(context, child, level + 1))
        .toList(),
  );
}

  IconData _getIcon(TreeNode node) {
    switch (node.type) {
      case TreeNodeType.location:
        return Icons.location_on;
      case TreeNodeType.asset:
        return Icons.precision_manufacturing;
      case TreeNodeType.component:
        return Icons.memory;
    }
  }
}