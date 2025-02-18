import 'package:equatable/equatable.dart';

class Pokemon extends Equatable {
  final int id;
  final String name;
  final List<String> types;
  final String imageUrl;

  Pokemon({
    required this.id,
    required this.name,
    required this.types,
    required this.imageUrl,
  }) {
    if (id < 0) throw AssertionError('ID must be non-negative');
    if (name.isEmpty) throw AssertionError('Name must not be empty');
    if (types.isEmpty) throw AssertionError('Types must not be empty');
  }

  @override
  List<Object?> get props => [id, name, types, imageUrl];
} 