import 'package:equatable/equatable.dart';

class GenresTv extends Equatable {
  final int id;
  final String name;

  const GenresTv({
    required this.id,
    required this.name,
  });

  @override
  List<Object> get props => [
        id,
        name,
      ];
}
