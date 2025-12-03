import 'characters_repository.dart';
import '../services/api_client.dart';
import '../../domain/models/character.dart';

import '../../utils/result.dart';

class CharactersRemoteRepository implements CharactersRepository {
  CharactersRemoteRepository({required ApiClient apiClient})
    : _apiClient = apiClient;
  final ApiClient _apiClient;

  @override
  Future<Result<Character>> getCharacterById(int id) async {
    return _apiClient.getCharacter(id);
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
