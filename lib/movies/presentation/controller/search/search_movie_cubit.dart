import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/movies/domain/useCase/get_search_movie_usecase.dart';
import 'package:movies/movies/presentation/controller/search/search_movie_state.dart';

class SearchMovieCubit extends Cubit<SearchMovieState> {
  SearchMovieCubit(
    this.searchMoviesUseCase,
  ) : super(SearchMovieInitial());

  final SearchMoviesUseCase searchMoviesUseCase;
  String? query;
  bool hasSearchResults = false; // Add this flag
  String? data;

  Future<void> fetchSearchMovie({required String query}) async {
    emit(SearchMovieLoading());
    final result = await searchMoviesUseCase(SearchMoviesParams(query: query));
    result.fold(
      (failure) {
        emit(SearchMovieFailure(failure.message));
      },
      (movies) {
        emit(SearchMovieSuccess(movies));
      },
    );
  }
}
