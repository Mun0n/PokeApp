import 'dart:convert';
import 'package:clean_arch_demo/core/error/exceptions.dart';
import 'package:clean_arch_demo/features/pokemon/data/datasources/pokemon_remote_data_source.dart';
import 'package:clean_arch_demo/features/pokemon/data/models/pokemon_list_response.dart';
import 'package:clean_arch_demo/features/pokemon/data/models/pokemon_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'pokemon_remote_data_source_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late PokemonRemoteDataSourceImpl dataSource;
  late MockClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockClient();
    dataSource = PokemonRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('getPokemonList', () {
    final tPokemonListResponse = PokemonListResponse(
      count: 1,
      next: null,
      previous: null,
      results: [
        PokemonListItem(
          name: "bulbasaur",
          url: "https://pokeapi.co/api/v2/pokemon/1/",
        ),
      ],
    );

    test('should perform a GET request on a URL with offset/limit being the endpoint', () async {
      // arrange
      when(mockHttpClient.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response(
                json.encode({
                  "count": 1,
                  "next": null,
                  "previous": null,
                  "results": [
                    {
                      "name": "bulbasaur",
                      "url": "https://pokeapi.co/api/v2/pokemon/1/"
                    }
                  ]
                }),
                200,
              ));

      // act
      await dataSource.getPokemonList(offset: 0, limit: 1);

      // assert
      verify(mockHttpClient.get(
        Uri.parse('https://pokeapi.co/api/v2/pokemon?offset=0&limit=1'),
        headers: {'Content-Type': 'application/json'},
      ));
    });

    test('should return PokemonListResponse when the response code is 200', () async {
      // arrange
      when(mockHttpClient.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response(
                json.encode({
                  "count": 1,
                  "next": null,
                  "previous": null,
                  "results": [
                    {
                      "name": "bulbasaur",
                      "url": "https://pokeapi.co/api/v2/pokemon/1/"
                    }
                  ]
                }),
                200,
              ));

      // act
      final result = await dataSource.getPokemonList(offset: 0, limit: 1);

      // assert
      expect(result, equals(tPokemonListResponse));
    });

    test('should throw a ServerException when the response code is not 200', () async {
      // arrange
      when(mockHttpClient.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response('Something went wrong', 404));

      // act
      final call = dataSource.getPokemonList;

      // assert
      expect(() => call(offset: 0, limit: 1), throwsA(isA<ServerException>()));
    });
  });

  group('getPokemonDetail', () {
    final tPokemonModel = PokemonModel(
      id: 1,
      name: "bulbasaur",
      types: ["grass", "poison"],
      imageUrl: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png",
    );

    test('should perform a GET request on a URL with identifier being the endpoint', () async {
      // arrange
      when(mockHttpClient.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response(
                json.encode({
                  "id": 1,
                  "name": "bulbasaur",
                  "types": [
                    {
                      "slot": 1,
                      "type": {"name": "grass", "url": "https://pokeapi.co/api/v2/type/12/"}
                    },
                    {
                      "slot": 2,
                      "type": {"name": "poison", "url": "https://pokeapi.co/api/v2/type/4/"}
                    }
                  ],
                  "sprites": {
                    "front_default":
                        "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png"
                  }
                }),
                200,
              ));

      // act
      await dataSource.getPokemonDetail(identifier: "1");

      // assert
      verify(mockHttpClient.get(
        Uri.parse('https://pokeapi.co/api/v2/pokemon/1'),
        headers: {'Content-Type': 'application/json'},
      ));
    });

    test('should return Pokemon when the response code is 200', () async {
      // arrange
      when(mockHttpClient.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response(
                json.encode({
                  "id": 1,
                  "name": "bulbasaur",
                  "types": [
                    {
                      "slot": 1,
                      "type": {"name": "grass", "url": "https://pokeapi.co/api/v2/type/12/"}
                    },
                    {
                      "slot": 2,
                      "type": {"name": "poison", "url": "https://pokeapi.co/api/v2/type/4/"}
                    }
                  ],
                  "sprites": {
                    "front_default":
                        "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png"
                  }
                }),
                200,
              ));

      // act
      final result = await dataSource.getPokemonDetail(identifier: "1");

      // assert
      expect(result, equals(tPokemonModel));
    });

    test('should throw a ServerException when the response code is not 200', () async {
      // arrange
      when(mockHttpClient.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response('Something went wrong', 404));

      // act
      final call = dataSource.getPokemonDetail;

      // assert
      expect(() => call(identifier: "1"), throwsA(isA<ServerException>()));
    });
  });
} 