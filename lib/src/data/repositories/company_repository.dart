import 'package:http/http.dart' as http;
import 'dart:convert';
import '../utils/constants.dart';
import '../models/company.dart';

class CompanyRepository {
  Future<List<Company>> getCompanies() async {
    final response = await http.get(Uri.parse('$baseUrl/companies'));

    if (response.statusCode == 200) {
      final List<dynamic> decoded = jsonDecode(response.body);
      return decoded.map((json) => Company.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load companies');
    }
  }
}