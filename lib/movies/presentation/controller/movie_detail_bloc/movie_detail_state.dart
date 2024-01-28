part of 'movie_detail_bloc.dart';

class MovieDetailState extends Equatable {
  const MovieDetailState({
    this.movieDetail,
    this.movieDetailState = RequestState.loading,
    this.messageMovieDetails = '',
    this.recommendationsMovie = const [],
    this.recommendationsState = RequestState.loading,
    this.recommendationsMessage = '',
  });

  final MovieDetail? movieDetail;
  final RequestState movieDetailState;
  final String messageMovieDetails;

  final List<Recommendation> recommendationsMovie;
  final RequestState recommendationsState;
  final String recommendationsMessage;

  MovieDetailState copyWith({
    MovieDetail? movieDetail,
    RequestState? movieDetailState,
    String? messageMovieDetails,
    List<Recommendation>? recommendationsMovie,
    RequestState? recommendationsState,
    String? recommendationsMessage,
  }) {
    return MovieDetailState(
      movieDetail: movieDetail ?? this.movieDetail,
      movieDetailState: movieDetailState ?? this.movieDetailState,
      messageMovieDetails: messageMovieDetails ?? this.messageMovieDetails,
      recommendationsMovie: recommendationsMovie ?? this.recommendationsMovie,
      recommendationsState: recommendationsState ?? this.recommendationsState,
      recommendationsMessage:
          recommendationsMessage ?? this.recommendationsMessage,
    );
  }

  @override
  List<Object?> get props => [
        movieDetail,
        movieDetailState,
        messageMovieDetails,
        recommendationsMovie,
        recommendationsState,
        recommendationsMessage,
      ];
}
