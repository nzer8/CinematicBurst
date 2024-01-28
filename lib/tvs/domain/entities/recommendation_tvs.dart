import 'package:equatable/equatable.dart';

class RecommendationTvs extends Equatable {
  final String? backdropPath;
  final int id;

  const RecommendationTvs({this.backdropPath, required this.id});

  @override
  List<Object?> get props => [backdropPath, id];
}
