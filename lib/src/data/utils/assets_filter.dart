import 'package:flutter_application_1/src/data/models/asset.dart';
import 'package:flutter_application_1/src/data/models/location.dart';

({List<Asset> assets, List<Location> locations}) filterAssetsByCustomFilter({ // O(n) por nível de profundidade
  required List<Asset> allAssets,
  required List<Location> allLocations,
  required bool Function(Asset) assetFilter,
}) {
  final Set<Asset> relevantAssets = {};
  final Set<Location> relevantLocations = {};

  Asset? findAsset(String id) {
    return allAssets.firstWhere((asset) => asset.id == id);
  }

  Location? findLocation(String id) {
    return allLocations.firstWhere((location) => location.id == id);
  }
  
  void collectLocationParents(Location location) {
    relevantLocations.add(location);
    if (location.parentId != null) {
      final parent = findLocation(location.parentId!);
      if (parent != null) collectLocationParents(parent);
    }
  }

  void getAssetParents(Asset asset) {
    relevantAssets.add(asset);

    if (asset.parentId != null) {
      final parent = findAsset(asset.parentId!);
      if (parent != null) getAssetParents(parent);
    } else if (asset.locationId != null) {
      final loc = findLocation(asset.locationId!);
      if (loc != null) collectLocationParents(loc);
    }
  }

  final filteredAssets = allAssets.where(assetFilter);
  for (final component in filteredAssets) {
    getAssetParents(component);
  }

  return (
    assets: relevantAssets.toList(),
    locations: relevantLocations.toList(),
  );
}