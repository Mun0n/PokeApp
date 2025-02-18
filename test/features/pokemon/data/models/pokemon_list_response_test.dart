import 'dart:convert';
import 'package:clean_arch_demo/features/pokemon/data/models/pokemon_list_response.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tPokemonListResponse = PokemonListResponse(
    count: 1281,
    next: "https://pokeapi.co/api/v2/pokemon?offset=20&limit=20",
    previous: null,
    results: [
      PokemonListItem(
        name: "bulbasaur",
        url: "https://pokeapi.co/api/v2/pokemon/1/",
      ),
      PokemonListItem(
        name: "ivysaur",
        url: "https://pokeapi.co/api/v2/pokemon/2/",
      ),
    ],
  );

  group('fromJson', () {
    test('should return a valid model from JSON', () {
      // arrange
      final Map<String, dynamic> jsonMap = {
        "count": 1281,
        "next": "https://pokeapi.co/api/v2/pokemon?offset=20&limit=20",
        "previous": null,
        "results": [
          {
            "name": "bulbasaur",
            "url": "https://pokeapi.co/api/v2/pokemon/1/"
          },
          {
            "name": "ivysaur",
            "url": "https://pokeapi.co/api/v2/pokemon/2/"
          }
        ]
      };

      // act
      final result = PokemonListResponse.fromJson(jsonMap);

      // assert
      expect(result, tPokemonListResponse);
    });

    test('should throw FormatException when JSON is invalid', () {
      // arrange
      final Map<String, dynamic> jsonMap = {
        "count": 1281,
        // missing results
      };

      // act & assert
      expect(() => PokemonListResponse.fromJson(jsonMap), throwsFormatException);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () {
      // act
      final result = tPokemonListResponse.toJson();

      // assert
      final expectedMap = {
        "count": 1281,
        "next": "https://pokeapi.co/api/v2/pokemon?offset=20&limit=20",
        "previous": null,
        "results": [
          {
            "name": "bulbasaur",
            "url": "https://pokeapi.co/api/v2/pokemon/1/"
          },
          {
            "name": "ivysaur",
            "url": "https://pokeapi.co/api/v2/pokemon/2/"
          }
        ]
      };
      expect(result, expectedMap);
    });
  });
} 