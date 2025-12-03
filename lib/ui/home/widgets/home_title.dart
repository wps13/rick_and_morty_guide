import 'package:flutter/material.dart';

class HomeTitle extends StatelessWidget {
  const HomeTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Guia do multiverso',
      style: Theme.of(context).textTheme.displayLarge?.copyWith(
        shadows: [
          Shadow(
            blurRadius: 5.0,
            color: Colors.black.withValues(alpha: 0.5),
            offset: const Offset(2.0, 2.0),
          ),
        ],
      ),
    );
  }
}
