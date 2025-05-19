import 'package:flutter_application_1/src/data/models/asset.dart';
import 'package:flutter_application_1/src/data/models/location.dart';
import 'package:flutter_application_1/src/data/models/tree_node.dart';

List<TreeNode> buildTree({ // Complexidade 2x O(locations) + 2x O(assets)
  required List<Location> locations,
  required List<Asset> assets,
}) {
  final Map<String, TreeNode> locationMap = {};
  final Map<String, TreeNode> assetMap = {};
  final List<TreeNode> roots = [];

  // Cria os nós para locations
  for (final location in locations) {
    locationMap[location.id] = TreeNode(
      id: location.id,
      name: location.name,
      type: TreeNodeType.location,
      data: location,
      children: [],
    );
  }

  // Liga sublocations a seus pais
  for (final location in locations) {
    final node = locationMap[location.id]!;
    if (location.parentId != null && locationMap.containsKey(location.parentId)) {
      locationMap[location.parentId]!.children.add(node);
    } else {
      roots.add(node);
    }
  }

  // Cria nós para assets
  for (final asset in assets) {
    final type = asset.sensorType != null
        ? TreeNodeType.component
        : TreeNodeType.asset;

    assetMap[asset.id] = TreeNode(
      id: asset.id,
      name: asset.name,
      type: type,
      data: asset,
      children: [],
    );
  }

  // Liga assets e components aos pais
  for (final asset in assets) {
    final node = assetMap[asset.id]!;

    if (asset.sensorType != null) {
      // COMPONENTE
      if (asset.parentId != null && assetMap.containsKey(asset.parentId)) {
        assetMap[asset.parentId]!.children.add(node);
      } else if (asset.locationId != null && locationMap.containsKey(asset.locationId)) {
        locationMap[asset.locationId]!.children.add(node);
      } else {
        roots.add(node);
      }
    } else {
      // ASSET
      if (asset.parentId != null && assetMap.containsKey(asset.parentId)) {
        assetMap[asset.parentId]!.children.add(node);
      } else if (asset.locationId != null && locationMap.containsKey(asset.locationId)) {
        locationMap[asset.locationId]!.children.add(node);
      } else {
        roots.add(node);
      }
    }
  }

  return roots;
}
