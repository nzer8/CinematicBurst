part of 'see_more_tv_bloc.dart';

class SeeMoreTvState extends Equatable {
  final List<Tvs> popularTv;
  final RequestState popularTvState;
  final String popularTvMessage;

  final List<Tvs> topRatedTv;
  final RequestState topRatedTvState;
  final String topRatedTvMessage;

  const SeeMoreTvState({
    this.popularTv = const [],
    this.popularTvState = RequestState.loading,
    this.popularTvMessage = '',
    this.topRatedTv = const [],
    this.topRatedTvState = RequestState.loading,
    this.topRatedTvMessage = '',
  });

  SeeMoreTvState copyWith({
    List<Tvs>? popularTv,
    RequestState? popularTvState,
    String? popularTvMessage,
    List<Tvs>? topRatedTv,
    RequestState? topRatedTvState,
    String? topRatedTvMessage,
  }) {
    return SeeMoreTvState(
      popularTv: popularTv ?? this.popularTv,
      popularTvState: popularTvState ?? this.popularTvState,
      popularTvMessage: popularTvMessage ?? this.popularTvMessage,
      topRatedTv: topRatedTv ?? this.topRatedTv,
      topRatedTvState: topRatedTvState ?? this.topRatedTvState,
      topRatedTvMessage: topRatedTvMessage ?? this.topRatedTvMessage,
    );
  }

  @override
  List<Object> get props => [
        popularTv,
        popularTvState,
        popularTvMessage,
        topRatedTv,
        topRatedTvState,
        topRatedTvMessage,
      ];
}
