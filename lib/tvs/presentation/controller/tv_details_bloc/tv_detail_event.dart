part of 'tv_detail_bloc.dart';

abstract class TvDetailEvent extends Equatable {
  const TvDetailEvent();
}

class GetTvDetailsEvent extends TvDetailEvent {
  final int id;
  const GetTvDetailsEvent(this.id);

  @override
  List<Object> get props => [id];
}

class GetTvRecommendationEvent extends TvDetailEvent {
  final int id;
  const GetTvRecommendationEvent(this.id);

  @override
  List<Object> get props => [id];
}
