import 'package:clean_arch_demo/core/error/failures.dart';
import 'package:clean_arch_demo/features/pokemon/domain/entities/pokemon.dart';
import 'package:clean_arch_demo/features/pokemon/domain/repositories/pokemon_repository.dart';
import 'package:clean_arch_demo/features/pokemon/domain/usecases/get_pokemon_list.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_pokemon_list_test.mocks.dart';

@GenerateMocks([PokemonRepository])
void main() {
  late GetPokemonList usecase;
  late MockPokemonRepository mockPokemonRepository;

  setUp(() {
    mockPokemonRepository = MockPokemonRepository();
    usecase = GetPokemonList(repository: mockPokemonRepository);
  });

  final tParams = PokemonListParams(offset: 0, limit: 20);
  final tPokemonList = [
    Pokemon(
      id: 1,
      name: 'bulbasaur',
      types: ['grass', 'poison'],
      imageUrl: 'https://example.com/1.png',
    ),
  ];

  test('should get pokemon list from the repository', () async {
    // arrange
    when(mockPokemonRepository.getPokemonList(
      offset: tParams.offset,
      limit: tParams.limit,
    )).thenAnswer((_) async => Right(tPokemonList));

    // act
    final result = await usecase(tParams);

    // assert
    expect(result, Right(tPokemonList));
    verify(mockPokemonRepository.getPokemonList(
      offset: tParams.offset,
      limit: tParams.limit,
    ));
    verifyNoMoreInteractions(mockPokemonRepository);
  });

  test('should return ServerFailure when repository fails', () async {
    // arrange
    final failure = ServerFailure(message: 'Server error');
    when(mockPokemonRepository.getPokemonList(
      offset: tParams.offset,
      limit: tParams.limit,
    )).thenAnswer((_) async => Left(failure));

    // act
    final result = await usecase(tParams);

    // assert
    expect(result, Left(failure));
    verify(mockPokemonRepository.getPokemonList(
      offset: tParams.offset,
      limit: tParams.limit,
    ));
    verifyNoMoreInteractions(mockPokemonRepository);
  });
} 