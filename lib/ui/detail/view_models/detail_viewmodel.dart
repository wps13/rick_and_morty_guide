import 'package:flutter/material.dart';
import '../../../data/repositories/characters_repository.dart';
import '../../../domain/models/character.dart';
import '../../../utils/result.dart';

class DetailViewModel extends ChangeNotifier {
  DetailViewModel({required CharactersRepository charactersRepository})
    : _charactersRepository = charactersRepository;

  final CharactersRepository _charactersRepository;

  Character? _character;
  Character? get character => _character;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _hasError = false;
  bool get hasError => _hasError;

  Future<void> getCharacter(int id) async {
    _isLoading = true;
    _hasError = false;
    notifyListeners();

    final result = await _charactersRepository.getCharacterById(id);

    switch (result) {
      case Ok<Character>():
        _character = result.value;
      case Error<Character>():
        _hasError = true;
    }

    _isLoading = false;
    notifyListeners();
  }
}
