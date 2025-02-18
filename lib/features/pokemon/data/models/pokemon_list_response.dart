import 'package:equatable/equatable.dart';

class PokemonListResponse extends Equatable {
  final int count;
  final String? next;
  final String? previous;
  final List<PokemonListItem> results;

  const PokemonListResponse({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
  });

  factory PokemonListResponse.fromJson(Map<String, dynamic> json) {
    if (!json.containsKey('results')) {
      throw FormatException('Invalid Pokemon list JSON: missing results');
    }

    return PokemonListResponse(
      count: json['count'] as int,
      next: json['next'] as String?,
      previous: json['previous'] as String?,
      results: (json['results'] as List)
          .map((item) => PokemonListItem.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'count': count,
      'next': next,
      'previous': previous,
      'results': results.map((item) => item.toJson()).toList(),
    };
  }

  @override
  List<Object?> get props => [count, next, previous, results];
}

class PokemonListItem extends Equatable {
  final String name;
  final String url;

  const PokemonListItem({
    required this.name,
    required this.url,
  });

  factory PokemonListItem.fromJson(Map<String, dynamic> json) {
    return PokemonListItem(
      name: json['name'] as String,
      url: json['url'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'url': url,
    };
  }

  @override
  List<Object?> get props => [name, url];
} 