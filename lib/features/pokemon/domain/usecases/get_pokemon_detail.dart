import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/pokemon.dart';
import '../repositories/pokemon_repository.dart';

class GetPokemonDetail implements UseCase<Pokemon, PokemonDetailParams> {
  final PokemonRepository repository;

  GetPokemonDetail({required this.repository});

  @override
  Future<Either<Failure, Pokemon>> call(PokemonDetailParams params) async {
    return await repository.getPokemonDetail(
      identifier: params.identifier,
    );
  }
}

class PokemonDetailParams extends Equatable {
  final String identifier;

  PokemonDetailParams({
    required this.identifier,
  }) {
    if (identifier.isEmpty) throw AssertionError('Identifier must not be empty');
  }

  @override
  List<Object> get props => [identifier];
} 