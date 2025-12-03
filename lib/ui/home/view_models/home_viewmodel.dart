import 'dart:async';

import 'package:flutter/material.dart';
import '../../../data/repositories/characters_repository.dart';
import '../../../domain/models/character.dart';

import '../../../utils/result.dart';

class HomeViewModel extends ChangeNotifier {
  HomeViewModel({required CharactersRepository charactersRepository})
    : _charactersRepository = charactersRepository;

  final CharactersRepository _charactersRepository;
  CharactersRepository get charactersRepository => _charactersRepository;

  final List<String> availableStatusFilters = [
    'Todos',
    'Vivo',
    'Morto',
    'Desconhecido',
  ];
  String selectedStatusFilter = 'Todos';
  List<Character> characters = [];
  bool isLoading = false;
  bool hasError = false;
  Timer? searchTimer;
  int page = 1;
  String? searchNameQuery;

  bool isLoadingMore = false;
  bool hasReachedEnd = false;
  bool get canLoadMore =>
      !isLoading && !isLoadingMore && !hasError && !hasReachedEnd;

  List<String> get statusFilters => availableStatusFilters;

  String? get selectedStatus => selectedStatusFilter;

  void onStatusFilterChanged(String status) {
    final isStatusValid = availableStatusFilters.contains(status);
    if (!isStatusValid) return;
    if (selectedStatusFilter == status) return;

    selectedStatusFilter = status;
    _resetAndReload();
  }

  void onSearchChanged(String query) {
    // Add delay to prevent multiple requests
    searchTimer?.cancel();
    searchTimer = Timer(const Duration(seconds: 1), () {
      if (searchNameQuery == query) return;
      debugPrint('Search query: $query');
      searchNameQuery = query;
      _resetAndReload();
    });
  }

  Future<void> _resetAndReload() async {
    characters.clear();
    page = 1;
    hasError = false;
    hasReachedEnd = false;
    isLoading = true;
    notifyListeners();
    await getAllCharacters();
  }

  Future<void> getAllCharacters() async {
    try {
      final status = selectedStatusFilter == 'Todos'
          ? null
          : Status.toJson(selectedStatusFilter);

      final result = await _charactersRepository.getCharacters(
        page: page,
        statusFilter: status,
        nameQuery: searchNameQuery,
      );

      switch (result) {
        case Ok<List<Character>>():
          if (result.value.isEmpty) {
            hasReachedEnd = true;
          } else {
            characters.addAll(result.value);
            page++;
            if (result.value.length < 20) {
              hasReachedEnd = true;
            }
          }
          hasError = false;
        case Error<List<Character>>():
          // If 404, it usually means end of list
          if (result.error.toString().contains('404')) {
            hasReachedEnd = true;
            hasError = false;
          } else {
            debugPrint('error na request: ${result.error}');
            hasError = true;
          }
      }
    } catch (e) {
      hasError = true;
    } finally {
      isLoading = false;
      isLoadingMore = false;
      notifyListeners();
    }
  }

  Future<void> loadMoreCharacters() async {
    if (!canLoadMore) return;

    isLoadingMore = true;
    notifyListeners();
    await getAllCharacters();
  }
}
