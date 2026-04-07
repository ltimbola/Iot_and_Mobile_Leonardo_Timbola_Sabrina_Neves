import 'package:flutter/material.dart';
import '../../../core/routes/app_routes.dart';

class GoToSongsButton extends StatelessWidget {
  final String selectedOrFallbackName;

  const GoToSongsButton({
    super.key,
    required this.selectedOrFallbackName,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
      onPressed: () => Navigator.pushNamed(
        context,
        AppRoutes.songs,
        arguments: selectedOrFallbackName,
      ),
      icon: const Icon(Icons.arrow_forward),
      label: const Text('Ir para músicas'),
    );
  }
}
