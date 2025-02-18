import 'package:dartz/dartz.dart';
import '../entities/pokemon.dart';
import '../../../../core/error/failures.dart';

abstract class PokemonRepository {
  /// Gets a paginated list of Pokemon
  /// 
  /// [offset] is the number of items to skip
  /// [limit] is the maximum number of items to return
  /// 
  /// Returns Either a Failure or a List of Pokemon
  Future<Either<Failure, List<Pokemon>>> getPokemonList({
    required int offset,
    required int limit,
  });

  /// Gets detailed information about a specific Pokemon
  /// 
  /// [identifier] can be either the Pokemon's ID or name
  /// 
  /// Returns Either a Failure or a Pokemon
  Future<Either<Failure, Pokemon>> getPokemonDetail({
    required String identifier,
  });
} 