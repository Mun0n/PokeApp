import 'package:flutter_test/flutter_test.dart';
import 'package:clean_arch_demo/features/pokemon/domain/repositories/pokemon_repository.dart';

// This is an abstract test class that defines what ANY implementation 
// of PokemonRepository should be able to do
abstract class PokemonRepositoryTest {
  void getPokemonList();
  void getPokemonDetail();
}

void main() {
  group('PokemonRepository Interface', () {
    test('should define getPokemonList method', () {
      // This test just verifies the interface defines the method
      const methodName = 'getPokemonList';
      expect(
        PokemonRepository.toString().contains(methodName), 
        true,
        reason: 'PokemonRepository should define $methodName method',
      );
    });

    test('should define getPokemonDetail method', () {
      const methodName = 'getPokemonDetail';
      expect(
        PokemonRepository.toString().contains(methodName), 
        true,
        reason: 'PokemonRepository should define $methodName method',
      );
    });
  });
} 