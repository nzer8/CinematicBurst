part of 'tvs_bloc.dart';

class TvsState extends Equatable {
  final List<Tvs> onTheAirTv;
  final RequestState onTheAirTvState;
  final String onTheAirTvMessage;

  final List<Tvs> popularTv;
  final RequestState popularTvState;
  final String popularTvMessage;

  final List<Tvs> topRatedTv;
  final RequestState topRatedTvState;
  final String topRatedTvMessage;

  const TvsState({
    this.onTheAirTv = const [],
    this.onTheAirTvState = RequestState.loading,
    this.onTheAirTvMessage = '',
    this.popularTv = const [],
    this.popularTvState = RequestState.loading,
    this.popularTvMessage = '',
    this.topRatedTv = const [],
    this.topRatedTvState = RequestState.loading,
    this.topRatedTvMessage = '',
  });

  TvsState copyWith({
    List<Tvs>? onTheAirTv,
    RequestState? onTheAirTvState,
    String? onTheAirTvMessage,
    List<Tvs>? popularTv,
    RequestState? popularTvState,
    String? popularTvMessage,
    List<Tvs>? topRatedTv,
    RequestState? topRatedTvState,
    String? topRatedTvMessage,
  }) {
    return TvsState(
      onTheAirTv: onTheAirTv ?? this.onTheAirTv,
      //خود نفس القيمة القديمة وحطها nullيعني القيمة اذا ب
      onTheAirTvState: onTheAirTvState ?? this.onTheAirTvState,
      onTheAirTvMessage: onTheAirTvMessage ?? this.onTheAirTvMessage,

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
        onTheAirTv,
        onTheAirTvState,
        onTheAirTvMessage,
        popularTv,
        popularTvState,
        popularTvMessage,
        topRatedTv,
        topRatedTvState,
        topRatedTvMessage,
      ];
}
