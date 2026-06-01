import 'package:flutter/material.dart';
import '../../../core/routes/app_routes.dart';

class GoToSongsButton extends StatelessWidget {
  const GoToSongsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
      onPressed: () => Navigator.pushNamed(
        context,
        AppRoutes.musicas,
      ),
      icon: const Icon(Icons.arrow_forward),
      label: const Text('Ir para músicas'),
    );
  }
}
