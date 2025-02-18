import 'package:flutter_test/flutter_test.dart';
import 'package:clean_arch_demo/features/pokemon/domain/entities/pokemon.dart';

void main() {
  group('Pokemon Entity', () {
    test('should create a valid Pokemon entity with required fields', () {
      final pokemon = Pokemon(
        id: 1,
        name: 'bulbasaur',
        types: ['grass', 'poison'],
        imageUrl: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png',
      );

      expect(pokemon.id, 1);
      expect(pokemon.name, 'bulbasaur');
      expect(pokemon.types, ['grass', 'poison']);
      expect(pokemon.imageUrl, 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png');
    });

    test('should throw AssertionError when id is negative', () {
      expect(
        () => Pokemon(
          id: -1,
          name: 'bulbasaur',
          types: ['grass'],
          imageUrl: 'https://example.com/1.png',
        ),
        throwsAssertionError,
      );
    });

    test('should throw AssertionError when name is empty', () {
      expect(
        () => Pokemon(
          id: 1,
          name: '',
          types: ['grass'],
          imageUrl: 'https://example.com/1.png',
        ),
        throwsAssertionError,
      );
    });

    test('should throw AssertionError when types is empty', () {
      expect(
        () => Pokemon(
          id: 1,
          name: 'bulbasaur',
          types: [],
          imageUrl: 'https://example.com/1.png',
        ),
        throwsAssertionError,
      );
    });
  });
} 