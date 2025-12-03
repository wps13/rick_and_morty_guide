import '../../domain/models/character.dart';
import '../../utils/result.dart';

abstract class CharactersRepository {
  Future<Result<Character>> getCharacterById(int id);
  Future<Result<List<Character>>> getCharacters({
    required int page,
    String? statusFilter,
    String? nameQuery,
  });
}
