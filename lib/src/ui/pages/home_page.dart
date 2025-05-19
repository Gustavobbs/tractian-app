import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/data/models/company.dart';
import 'package:flutter_application_1/src/data/repositories/company_repository.dart';
import 'package:flutter_application_1/src/ui/pages/assets_page.dart';
import 'package:flutter_application_1/src/ui/widgets/button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Company> _companies = [];
  final CompanyRepository _companyRepository = CompanyRepository();

  @override
  void initState() {
    super.initState();
    _fetchCompanies();
  }

  void _fetchCompanies() async {
    try {
      final companies = await _companyRepository.getCompanies();
      setState(() {
        _companies = companies;
      });
    } catch (e) {
      debugPrint('Erro ao buscar companhias: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).padding.top),
          Container(
            height: 80,
            color: Color(0xFF002060),
            alignment: Alignment.center,
            margin: EdgeInsets.only(bottom: 16),
            child: Image.asset(
              'images/LOGO_TRACTIAN.png',
              height: 30,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _companies.length,
              itemBuilder: (context, index) {
                final company = _companies[index];
                return CompanyButton(
                  label: company.name,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => AssetsPage(
                          companyId: company.id,
                          companyName: company.name
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
