import 'package:flutter/material.dart';

class FiltersBar extends StatelessWidget {
  final String search;
  final ValueChanged<String> onSearchChanged;
  final bool filterEnergy;
  final bool filterAlert;
  final VoidCallback onToggleEnergy;
  final VoidCallback onToggleAlert;

  const FiltersBar({
    super.key,
    required this.search,
    required this.onSearchChanged,
    required this.filterEnergy,
    required this.filterAlert,
    required this.onToggleEnergy,
    required this.onToggleAlert,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Buscar Ativo ou Componente',
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: Colors.grey.shade200,
              contentPadding: const EdgeInsets.symmetric(horizontal: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
            ),
            onChanged: onSearchChanged,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: onToggleEnergy,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: filterEnergy ? Colors.blue : Colors.white,
                    foregroundColor: filterEnergy ? Colors.white : Colors.black,
                    side: const BorderSide(color: Colors.blue),
                    elevation: 0,
                  ),
                  icon: const Icon(Icons.flash_on),
                  label: const Text('Sensor de Energia'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: onToggleAlert,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: filterAlert ? Colors.blue : Colors.white,
                    foregroundColor: filterAlert ? Colors.white : Colors.black,
                    elevation: 1,
                  ),
                  icon: const Icon(Icons.info_outline),
                  label: const Text('Crítico'),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}