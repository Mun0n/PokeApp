import 'dart:convert';
import 'package:clean_arch_demo/features/pokemon/data/models/pokemon_model.dart';
import 'package:clean_arch_demo/features/pokemon/domain/entities/pokemon.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tPokemonModel = PokemonModel(
    id: 1,
    name: 'bulbasaur',
    types: ['grass', 'poison'],
    imageUrl: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png',
  );

  test('should be a subclass of Pokemon entity', () {
    expect(tPokemonModel, isA<Pokemon>());
  });

  group('fromJson', () {
    test('should return a valid model from JSON', () {
      // arrange
      final Map<String, dynamic> jsonMap = {
        "id": 1,
        "name": "bulbasaur",
        "types": [
          {
            "slot": 1,
            "type": {
              "name": "grass",
              "url": "https://pokeapi.co/api/v2/type/12/"
            }
          },
          {
            "slot": 2,
            "type": {
              "name": "poison",
              "url": "https://pokeapi.co/api/v2/type/4/"
            }
          }
        ],
        "sprites": {
          "front_default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png"
        }
      };

      // act
      final result = PokemonModel.fromJson(jsonMap);

      // assert
      expect(result, tPokemonModel);
    });

    test('should throw FormatException when JSON is invalid', () {
      // arrange
      final Map<String, dynamic> jsonMap = {
        "id": 1,
        "name": "bulbasaur",
        // missing types and sprites
      };

      // act & assert
      expect(() => PokemonModel.fromJson(jsonMap), throwsFormatException);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () {
      // act
      final result = tPokemonModel.toJson();

      // assert
      final expectedMap = {
        "id": 1,
        "name": "bulbasaur",
        "types": ["grass", "poison"],
        "imageUrl": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png",
      };
      expect(result, expectedMap);
    });
  });
} 