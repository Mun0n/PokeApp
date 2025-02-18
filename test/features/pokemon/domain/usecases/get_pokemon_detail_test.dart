import 'package:clean_arch_demo/core/error/failures.dart';
import 'package:clean_arch_demo/features/pokemon/domain/entities/pokemon.dart';
import 'package:clean_arch_demo/features/pokemon/domain/repositories/pokemon_repository.dart';
import 'package:clean_arch_demo/features/pokemon/domain/usecases/get_pokemon_detail.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_pokemon_detail_test.mocks.dart';

@GenerateMocks([PokemonRepository])
void main() {
  late GetPokemonDetail usecase;
  late MockPokemonRepository mockPokemonRepository;

  setUp(() {
    mockPokemonRepository = MockPokemonRepository();
    usecase = GetPokemonDetail(repository: mockPokemonRepository);
  });

  final tParams = PokemonDetailParams(identifier: '1');
  final tPokemon = Pokemon(
    id: 1,
    name: 'bulbasaur',
    types: ['grass', 'poison'],
    imageUrl: 'https://example.com/1.png',
  );

  test('should get pokemon detail from the repository', () async {
    // arrange
    when(mockPokemonRepository.getPokemonDetail(
      identifier: tParams.identifier,
    )).thenAnswer((_) async => Right(tPokemon));

    // act
    final result = await usecase(tParams);

    // assert
    expect(result, Right(tPokemon));
    verify(mockPokemonRepository.getPokemonDetail(
      identifier: tParams.identifier,
    ));
    verifyNoMoreInteractions(mockPokemonRepository);
  });

  test('should return ServerFailure when repository fails', () async {
    // arrange
    final failure = ServerFailure(message: 'Server error');
    when(mockPokemonRepository.getPokemonDetail(
      identifier: tParams.identifier,
    )).thenAnswer((_) async => Left(failure));

    // act
    final result = await usecase(tParams);

    // assert
    expect(result, Left(failure));
    verify(mockPokemonRepository.getPokemonDetail(
      identifier: tParams.identifier,
    ));
    verifyNoMoreInteractions(mockPokemonRepository);
  });
} 