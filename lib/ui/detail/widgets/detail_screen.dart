import 'package:flutter/material.dart';
import '../view_models/detail_viewmodel.dart';
import 'detail_info_card.dart';
import 'detail_info_row.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({
    super.key,
    required this.viewmodel,
    required this.characterId,
  });

  final DetailViewModel viewmodel;
  final int characterId;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  void initState() {
    super.initState();
    widget.viewmodel.getCharacter(widget.characterId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes do Personagem'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: ListenableBuilder(
        listenable: widget.viewmodel,
        builder: (context, child) {
          if (widget.viewmodel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (widget.viewmodel.hasError || widget.viewmodel.character == null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Erro ao carregar personagem'),
                  ElevatedButton(
                    onPressed: () =>
                        widget.viewmodel.getCharacter(widget.characterId),
                    child: const Text('Tentar novamente'),
                  ),
                ],
              ),
            );
          }

          final character = widget.viewmodel.character!;

          return SafeArea(
            top: false,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      character.imageUrl,
                      height: 300,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 16,
                    ),
                    decoration: BoxDecoration(
                      color: character.status.color.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: character.status.color),
                    ),
                    child: Text(
                      'STATUS: ${character.status.label.toUpperCase()}',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: character.status.color,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  DetailInfoCard(
                    title: 'Informações Pessoais',
                    icon: Icons.person_outline,
                    children: [
                      DetailInfoRow(label: 'Espécie', value: character.species),
                      DetailInfoRow(
                        label: 'Gênero',
                        value: character.gender.label,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  DetailInfoCard(
                    title: 'Origem e Localização',
                    icon: Icons.location_on_outlined,
                    children: [
                      DetailInfoRow(
                        label: 'Origem',
                        value: character.originName,
                      ),
                      DetailInfoRow(
                        label: 'Local Atual',
                        value: character.locationName,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  DetailInfoCard(
                    title: 'Episódios',
                    icon: Icons.tv,
                    children: [
                      DetailInfoRow(
                        label: 'Episódios',
                        value: character.episodesCount.toString(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
