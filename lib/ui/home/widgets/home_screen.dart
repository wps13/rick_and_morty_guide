import 'package:flutter/material.dart';
import 'package:rick_and_morty_guide/ui/home/widgets/home_character_card.dart';
import 'package:rick_and_morty_guide/ui/home/widgets/home_error_widget.dart';
import 'package:rick_and_morty_guide/ui/home/widgets/home_skeleton.dart';
import 'package:rick_and_morty_guide/ui/home/widgets/home_status_filter.dart';

import '../view_models/home_viewmodel.dart';
import 'home_search_field.dart';
import 'home_title.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.viewmodel});

  final HomeViewModel viewmodel;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    widget.viewmodel.getAllCharacters();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      widget.viewmodel.loadMoreCharacters();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ListenableBuilder(
            listenable: widget.viewmodel,
            builder: (context, child) {
              return Column(
                children: [
                  HomeTitle(),
                  const SizedBox(height: 12),
                  HomeSearchField(onChanged: widget.viewmodel.onSearchChanged),
                  const SizedBox(height: 8),
                  HomeStatusFilter(
                    status: widget.viewmodel.availableStatusFilters,
                    onChanged: widget.viewmodel.onStatusFilterChanged,
                    currentStatus: widget.viewmodel.selectedStatusFilter,
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: Builder(
                      builder: (context) {
                        if (widget.viewmodel.isLoading) {
                          return const HomeSkeleton();
                        }

                        if (widget.viewmodel.hasError &&
                            widget.viewmodel.characters.isEmpty) {
                          return HomeErrorWidget(
                            onRetry: widget.viewmodel.getAllCharacters,
                          );
                        }

                        return ListView.builder(
                          controller: _scrollController,
                          itemCount:
                              widget.viewmodel.characters.length +
                              (widget.viewmodel.isLoadingMore ? 1 : 0),
                          itemBuilder: (context, index) {
                            if (index == widget.viewmodel.characters.length) {
                              return const Center(
                                child: Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            }
                            final character =
                                widget.viewmodel.characters[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: HomeCharacterCard(
                                name: character.name,
                                status: character.status.label,
                                species: character.species,
                                locationName: character.locationName,
                                image: character.imageUrl,
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
