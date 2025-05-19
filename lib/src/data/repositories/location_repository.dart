import 'package:http/http.dart' as http;
import 'dart:convert';
import '../utils/constants.dart';
import '../models/location.dart';

class LocationRepository {
  Future<List<Location>> getLocations(String companyId) async {
    final response = await http.get(Uri.parse('$baseUrl/companies/$companyId/locations'));

    if (response.statusCode == 200) {
      final List<dynamic> decoded = jsonDecode(response.body);
      return decoded.map((json) => Location.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load locations');
    }
  }
}