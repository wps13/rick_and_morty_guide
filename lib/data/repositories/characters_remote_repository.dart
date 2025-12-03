import 'package:rick_and_morty_guide/data/repositories/characters_repository.dart';
import 'package:rick_and_morty_guide/data/services/api_client.dart';
import 'package:rick_and_morty_guide/domain/models/character.dart';

import '../../utils/result.dart';

class CharactersRemoteRepository implements CharactersRepository {
  CharactersRemoteRepository({required ApiClient apiClient})
    : _apiClient = apiClient;
  final ApiClient _apiClient;

  @override
  Future<Result<Character>> getCharacterById(int id) {
    // TODO: implement getCharacterById
    throw UnimplementedError();
  }

  @override
  Future<Result<List<Character>>> getCharacters({
    required int page,
    String? statusFilter,
    String? nameQuery,
  }) async {
    final result = await _apiClient.getCharacters(
      page: page,
      statusFilter: statusFilter,
      nameQuery: nameQuery,
    );
    return result;
  }
}
