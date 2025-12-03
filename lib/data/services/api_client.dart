import 'dart:convert';
import 'dart:io';

import '../../domain/models/character.dart';
import '../../utils/result.dart';

class ApiClient {
  ApiClient({String? baseUrl, HttpClient Function()? clientFactory})
    : _baseUrl = baseUrl ?? 'https://rickandmortyapi.com/api',
      _clientFactory = clientFactory ?? HttpClient.new;

  final String _baseUrl;
  final HttpClient Function() _clientFactory;

  Future<Result<List<Character>>> getCharacters({
    required int page,
    String? statusFilter,
    String? nameQuery,
  }) async {
    final client = _clientFactory();
    try {
      final uri = Uri.parse('$_baseUrl/character').replace(
        queryParameters: {
          'page': page.toString(),
          if (nameQuery?.isNotEmpty == true) 'name': nameQuery,
          if (statusFilter?.isNotEmpty == true) 'status': statusFilter,
        },
      );

      // The following line is for debugging and can be removed.
      // It helps to see the final generated URL.
      // import 'package:flutter/foundation.dart';
      // debugPrint(uri.toString());

      final request = await client.getUrl(uri);

      final response = await request.close();

      if (response.statusCode == 200) {
        final stringData = await response.transform(utf8.decoder).join();
        final json = jsonDecode(stringData) as Map<String, dynamic>;
        final data = json.containsKey('results') ? json['results'] : [];
        final charactersList = data
            .map<Character>(
              (character) => Character.fromJson(
                (character as Map<String, dynamic>?) ?? {},
              ),
            )
            .toList();
        return Result.ok(charactersList);
      } else {
        return Result.error(HttpException('Error on request all characters'));
      }
    } on Exception catch (error) {
      return Result.error(error);
    } finally {
      client.close();
    }
  }

  Future<Result<Character>> getCharacter(int id) async {
    final client = _clientFactory();
    try {
      final uri = Uri.parse('$_baseUrl/character/$id');
      final request = await client.getUrl(uri);
      final response = await request.close();

      if (response.statusCode == 200) {
        final stringData = await response.transform(utf8.decoder).join();
        final json = jsonDecode(stringData) as Map<String, dynamic>;
        return Result.ok(Character.fromJson(json));
      } else {
        return Result.error(HttpException('Error on request character $id'));
      }
    } on Exception catch (error) {
      return Result.error(error);
    } finally {
      client.close();
    }
  }
}
