import '../../domain/entities/pokemon.dart';

class PokemonModel extends Pokemon {
  PokemonModel({
    required super.id,
    required super.name,
    required super.types,
    required super.imageUrl,
  });

  factory PokemonModel.fromJson(Map<String, dynamic> json) {
    if (!json.containsKey('types') || !json.containsKey('sprites')) {
      throw FormatException('Invalid Pokemon JSON: missing required fields');
    }

    final types = (json['types'] as List).map((type) => 
      type['type']['name'] as String
    ).toList();

    final imageUrl = json['sprites']['front_default'] as String?;
    if (imageUrl == null) {
      throw FormatException('Invalid Pokemon JSON: missing sprite URL');
    }

    return PokemonModel(
      id: json['id'] as int,
      name: json['name'] as String,
      types: types,
      imageUrl: imageUrl,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'types': types,
      'imageUrl': imageUrl,
    };
  }
} 