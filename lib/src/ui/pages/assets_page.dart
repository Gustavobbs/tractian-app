import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/data/repositories/asset_repository.dart';
import 'package:flutter_application_1/src/data/repositories/location_repository.dart';
import 'package:flutter_application_1/src/data/models/asset.dart';
import 'package:flutter_application_1/src/data/models/location.dart';
import 'package:flutter_application_1/src/data/utils/tree_builder.dart';
import 'package:flutter_application_1/src/data/models/tree_node.dart';
import 'package:flutter_application_1/src/ui/widgets/tree_view.dart';
import 'package:flutter_application_1/src/ui/widgets/filters_bar.dart';
import 'package:flutter_application_1/src/data/utils/assets_filter.dart';

class AssetsPage extends StatefulWidget {
  final String companyId;
  final String companyName;

  const AssetsPage({
    super.key,
    required this.companyId,
    required this.companyName,
  });

  @override
  State<AssetsPage> createState() => _AssetsPageState();
}

class _AssetsPageState extends State<AssetsPage> {
  final AssetRepository _assetRepository = AssetRepository();
  final LocationRepository _locationRepository = LocationRepository();

  Timer? _debounceTimer;
  bool _isLoading = true;
  List<Asset> _assets = [];
  List<Location> _locations = [];
  List<TreeNode> _tree = [];

  String _searchTerm = '';
  List<Location> _searchTermLocations = [];
  List<Asset> _searchTermAssets = [];

  bool _isEnergySensorFilter = false;
  bool _isInAlertFilter = false;

  @override
  void initState() {
    super.initState();
    _fetchAssetsAndLocations();
  }

  void _fetchAssetsAndLocations() async {
    try {
      final assets = await _assetRepository.getAssets(widget.companyId);
      final locations = await _locationRepository.getLocations(widget.companyId);

      setState(() {
        _isLoading = false;
        _assets = assets;
        _locations = locations;
        _tree = buildTree(locations: locations, assets: assets);
      });

      debugPrint('Assets carregados: ${assets.length}');
      debugPrint('Locations carregados: ${locations.length}');
    } catch (e) {
      debugPrint('Erro ao buscar dados: $e');
      setState(() => _isLoading = false);
    }
  }

  void _onFilterByEnergySensor() {
    final result = filterAssetsByCustomFilter(
      allAssets: _searchTermAssets.isEmpty ? _assets : _searchTermAssets,
      allLocations: _searchTermLocations.isEmpty ? _locations : _searchTermLocations,
      assetFilter: (a) => a.sensorType == 'energy'
    );
    
    setState(() {
      _isEnergySensorFilter = !_isEnergySensorFilter;
      if (_isEnergySensorFilter) {
        _isInAlertFilter = false;
        _tree = buildTree(locations: result.locations, assets: result.assets);
      } else {
        _tree = _searchTerm.isEmpty
          ? buildTree(locations: _locations, assets: _assets)
          : buildTree(locations: _searchTermLocations, assets: _searchTermAssets);
      }
    });
  }

  void _onFilterByAlertStatus() {
    final result = filterAssetsByCustomFilter(
      allAssets: _searchTermAssets.isEmpty ? _assets : _searchTermAssets,
      allLocations: _searchTermLocations.isEmpty ? _locations : _searchTermLocations,
      assetFilter: (a) => a.status == 'alert'
    );
    
    setState(() {
      _isInAlertFilter = !_isInAlertFilter;
      if (_isInAlertFilter) {
        _isEnergySensorFilter = false;
        _tree = buildTree(locations: result.locations, assets: result.assets);
      } else {
        _tree = _searchTerm.isEmpty
          ? buildTree(locations: _locations, assets: _assets)
          : buildTree(locations: _searchTermLocations, assets: _searchTermAssets);
      }
    });
  }

  void _onSearchTermChanged(String searchTerm) {
    setState(() {
      _searchTerm = searchTerm;
      _isLoading = true;
    });
    
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 700), () {
      _applySearchFilter(searchTerm);
      setState(() => _isLoading = false);
    });
  }

  void _applySearchFilter(String searchTerm) {
    setState(() {
      _isEnergySensorFilter = false;
      _isInAlertFilter = false;

      if (searchTerm.isEmpty) {
        _searchTermLocations = [];
        _searchTermAssets = [];
        _tree = buildTree(locations: _locations, assets: _assets);
      } else {
        final result = filterAssetsByCustomFilter(
          allAssets: _assets,
          allLocations: _locations,
          assetFilter: (a) {
            final assetName = a.name.toLowerCase().trim();
            final searchTermLower = searchTerm.toLowerCase().trim();
            return assetName.contains(searchTermLower);
          }
        );
        _searchTermLocations = result.locations;
        _searchTermAssets = result.assets;
        _tree = buildTree(locations: result.locations, assets: result.assets);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ativos de ${widget.companyName}'),
      ),
      body: Column(
        children: [
          FiltersBar(
            search: _searchTerm,
            onSearchChanged: _onSearchTermChanged,
            filterEnergy: _isEnergySensorFilter,
            filterAlert: _isInAlertFilter,
            onToggleEnergy: _onFilterByEnergySensor,
            onToggleAlert: _onFilterByAlertStatus,
          ),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : TreeView(nodes: _tree),
          ),
        ],
      ),
    );
  }
}