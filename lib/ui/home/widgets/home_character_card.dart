import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class HomeCharacterCard extends StatelessWidget {
  const HomeCharacterCard({
    super.key,
    required this.name,
    required this.status,
    required this.species,
    required this.locationName,
    required this.image,
  });

  final String name;
  final String status;
  final String species;
  final String locationName;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.green),
      ),
      child: Row(
        children: [
          CachedNetworkImage(
            fit: BoxFit.scaleDown,
            imageUrl: image,
            placeholder: (context, url) => CircularProgressIndicator(),
          ),
          const SizedBox(width: 10),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: .start,
              children: [
                Text(name),
                const SizedBox(height: 8),
                Text('$status - $species'),
                const SizedBox(height: 8),
                Text(locationName),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
