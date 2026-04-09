import 'package:flutter/material.dart';
import '../../../l10n/app_localizations.dart';

class HomeErrorWidget extends StatelessWidget {
  const HomeErrorWidget({super.key, required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/error_image.png', height: 150),
          const SizedBox(height: 16),
          Text(
            AppLocalizations.of(context).errorLoadingCharacters,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: onRetry,
            child: Text(AppLocalizations.of(context).retryButton),
          ),
        ],
      ),
    );
  }
}
