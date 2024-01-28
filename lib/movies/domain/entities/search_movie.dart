import 'package:equatable/equatable.dart';

class SearchMovie extends Equatable {
  final String? backdropPath;
  final String? overView;
  final String? title;
  final int id;

  const SearchMovie(
      {this.overView, this.title, this.backdropPath, required this.id});

  @override
  List<Object?> get props => [
        backdropPath,
        overView,
        title,
        id,
      ];
}
