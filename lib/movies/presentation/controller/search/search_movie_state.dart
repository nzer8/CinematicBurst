import 'package:movies/movies/domain/entities/search_movie.dart';

abstract class SearchMovieState {}

class SearchMovieInitial extends SearchMovieState {}

class SearchMovieLoading extends SearchMovieState {}

class SearchMovieSuccess extends SearchMovieState {
  final List<SearchMovie> movie;

  SearchMovieSuccess(this.movie);
}

class SearchMovieFailure extends SearchMovieState {
  final String errMessage;

  SearchMovieFailure(this.errMessage);
}
