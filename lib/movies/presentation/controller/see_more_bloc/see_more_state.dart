part of 'see_more_bloc.dart';

class SeeMoreState extends Equatable {
  final List<Movie> popularMovies;
  final RequestState popularState;
  final String popularMessage;

  final List<Movie> topRated;
  final RequestState topRatedState;
  final String topRatedMessage;

  const SeeMoreState({
    this.popularMovies = const [],
    this.popularState = RequestState.loading,
    this.popularMessage = '',
    this.topRated = const [],
    this.topRatedState = RequestState.loading,
    this.topRatedMessage = '',
  });

  SeeMoreState copyWith({
    List<Movie>? popularMovies,
    RequestState? popularState,
    String? popularMessage,
    List<Movie>? topRated,
    RequestState? topRatedState,
    String? topRatedMessage,
  }) {
    return SeeMoreState(
      popularMovies: popularMovies ?? this.popularMovies,
      popularState: popularState ?? this.popularState,
      popularMessage: popularMessage ?? this.popularMessage,
      topRated: topRated ?? this.topRated,
      topRatedState: topRatedState ?? this.topRatedState,
      topRatedMessage: topRatedMessage ?? this.topRatedMessage,
    );
  }

  @override
  List<Object> get props => [
        popularMovies,
        popularState,
        popularMessage,
        topRated,
        topRatedState,
        topRatedMessage,
      ];
}
