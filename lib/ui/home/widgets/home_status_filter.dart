import 'package:flutter/material.dart';

class HomeStatusFilter extends StatelessWidget {
  const HomeStatusFilter({
    super.key,
    required this.status,
    required this.onChanged,
    required this.currentStatus,
  });

  final List<String> status;
  final ValueChanged<String> onChanged;
  final String currentStatus;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 4,
      children: status.map((status) {
        return ChoiceChip(
          showCheckmark: false,
          label: Text(status),
          selected: currentStatus == status,
          onSelected: (selected) {
            if (selected) {
              onChanged(status);
            }
          },
        );
      }).toList(),
    );
  }
}
