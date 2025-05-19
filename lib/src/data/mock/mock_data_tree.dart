import 'package:flutter_application_1/src/data/models/tree_node.dart';

final List<TreeNode> mockTree = [
  TreeNode(
    id: '1',
    name: 'PRODUCTION AREA - RAW MATERIAL',
    type: TreeNodeType.location,
    children: [
      TreeNode(
        id: '2',
        name: 'CHARCOAL STORAGE SECTOR',
        type: TreeNodeType.location,
        children: [
          TreeNode(
            id: '3',
            name: 'CONVEYOR BELT ASSEMBLY',
            type: TreeNodeType.asset,
            children: [
              TreeNode(
                id: '4',
                name: 'MOTOR TC01 COAL UNLOADING AF02',
                type: TreeNodeType.asset,
                children: [
                  TreeNode(
                    id: '5',
                    name: 'MOTOR RT COAL AF01',
                    type: TreeNodeType.component,
                    children: [],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
      TreeNode(
        id: '6',
        name: 'Machinery House',
        type: TreeNodeType.location,
        children: [
          TreeNode(
            id: '7',
            name: 'MOTORS H12D',
            type: TreeNodeType.asset,
            children: [
              TreeNode(
                id: '8',
                name: 'MOTORS H12D - Stage 1',
                type: TreeNodeType.component,
              ),
              TreeNode(
                id: '9',
                name: 'MOTORS H12D - Stage 2',
                type: TreeNodeType.component,
              ),
              TreeNode(
                id: '10',
                name: 'MOTORS H12D - Stage 3',
                type: TreeNodeType.component,
              ),
            ],
          ),
        ],
      ),
      TreeNode(
        id: '11',
        name: 'EMPTY MACHINE HOUSE',
        type: TreeNodeType.location,
        children: [],
      ),
    ],
  ),
  TreeNode(
    id: '12',
    name: 'Fan - External',
    type: TreeNodeType.component,
    children: [],
  ),
];