import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/pokemon.dart';
import '../repositories/pokemon_repository.dart';

class GetPokemonList implements UseCase<List<Pokemon>, PokemonListParams> {
  final PokemonRepository repository;

  GetPokemonList({required this.repository});

  @override
  Future<Either<Failure, List<Pokemon>>> call(PokemonListParams params) async {
    return await repository.getPokemonList(
      offset: params.offset,
      limit: params.limit,
    );
  }
}

class PokemonListParams extends Equatable {
  final int offset;
  final int limit;

  PokemonListParams({
    required this.offset,
    required this.limit,
  }) {
    if (offset < 0) throw AssertionError('Offset must be non-negative');
    if (limit <= 0) throw AssertionError('Limit must be positive');
  }

  @override
  List<Object> get props => [offset, limit];
} 