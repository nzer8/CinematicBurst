import 'package:equatable/equatable.dart';

class SearchTvs extends Equatable {
  final String? backdropPath;
  final String? overView;
  final String? name;
  final int id;

  const SearchTvs(
      {this.overView, this.name, this.backdropPath, required this.id});

  @override
  List<Object?> get props => [
        backdropPath,
        overView,
        name,
        id,
      ];
}
