import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../core/error/exceptions.dart';
import '../models/pokemon_list_response.dart';
import '../models/pokemon_model.dart';

abstract class PokemonRemoteDataSource {
  /// Calls the https://pokeapi.co/api/v2/pokemon?offset={offset}&limit={limit} endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<PokemonListResponse> getPokemonList({
    required int offset,
    required int limit,
  });

  /// Calls the https://pokeapi.co/api/v2/pokemon/{identifier} endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<PokemonModel> getPokemonDetail({
    required String identifier,
  });
}

class PokemonRemoteDataSourceImpl implements PokemonRemoteDataSource {
  final http.Client client;
  final String baseUrl;

  PokemonRemoteDataSourceImpl({
    required this.client,
    this.baseUrl = 'https://pokeapi.co/api/v2',
  });

  @override
  Future<PokemonListResponse> getPokemonList({
    required int offset,
    required int limit,
  }) async {
    final response = await client.get(
      Uri.parse('$baseUrl/pokemon?offset=$offset&limit=$limit'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return PokemonListResponse.fromJson(json.decode(response.body));
    } else {
      throw ServerException(
        message: 'Failed to fetch Pokemon list: ${response.statusCode}',
      );
    }
  }

  @override
  Future<PokemonModel> getPokemonDetail({
    required String identifier,
  }) async {
    final response = await client.get(
      Uri.parse('$baseUrl/pokemon/$identifier'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return PokemonModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException(
        message: 'Failed to fetch Pokemon detail: ${response.statusCode}',
      );
    }
  }
} 