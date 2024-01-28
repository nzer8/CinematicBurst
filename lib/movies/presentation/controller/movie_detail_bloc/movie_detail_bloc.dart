import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/core/utils/enums.dart';
import 'package:movies/movies/domain/entities/movie_detail.dart';
import 'package:movies/movies/domain/entities/recommendations_movie.dart';
import 'package:movies/movies/domain/useCase/get_movie_details_usecase.dart';
import 'package:movies/movies/domain/useCase/get_recommendations_movie_usecase.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  MovieDetailBloc(
      this.getMovieDetailsUesCase, this.getRecommendationsMovieUseCase)
      : super(const MovieDetailState()) {
    on<GetMovieDetailsEvent>(_getMovieDetailsEvent);
    on<GetMovieRecommendationEvent>(_getMovieRecommendationEvent);
  }
  final GetMovieDetailsUesCase getMovieDetailsUesCase;
  final GetRecommendationsMovieUseCase getRecommendationsMovieUseCase;

  FutureOr<void> _getMovieDetailsEvent(
      GetMovieDetailsEvent event, Emitter<MovieDetailState> emit) async {
    final result =
        await getMovieDetailsUesCase(MovieDetailsParameters(movieId: event.id));
    result.fold(
      (l) => emit(state.copyWith(
        movieDetailState: RequestState.error,
        messageMovieDetails: l.message,
      )),
      (r) => emit(
        state.copyWith(
          movieDetail: r,
          movieDetailState: RequestState.loaded,
        ),
      ),
    );
  }

  FutureOr<void> _getMovieRecommendationEvent(
      GetMovieRecommendationEvent event, Emitter<MovieDetailState> emit) async {
    final result = await getRecommendationsMovieUseCase(
        RecommendationParameters(movieId: event.id));
    print(result);
    result.fold(
      (l) => emit(state.copyWith(
        recommendationsState: RequestState.error,
        recommendationsMessage: l.message,
      )),
      (r) => emit(
        state.copyWith(
          recommendationsMovie: r,
          recommendationsState: RequestState.loaded,
        ),
      ),
    );
  }
}
