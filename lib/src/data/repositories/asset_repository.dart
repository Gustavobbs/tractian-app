import 'package:http/http.dart' as http;
import 'dart:convert';
import '../utils/constants.dart';
import '../models/asset.dart';

class AssetRepository {
  Future<List<Asset>> getAssets(String companyId) async {
    final response = await http.get(Uri.parse('$baseUrl/companies/$companyId/assets'));

    if (response.statusCode == 200) {
      final List<dynamic> decoded = jsonDecode(response.body);
      return decoded.map((json) => Asset.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load assets');
    }
  }
}