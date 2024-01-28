import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/core/usecase/base_usecase.dart';
import 'package:movies/core/utils/enums.dart';
import 'package:movies/movies/domain/useCase/get_now_play_movie_use_case.dart';
import 'package:movies/movies/domain/useCase/get_popular_movie_usecase.dart';
import 'package:movies/movies/domain/useCase/get_top_rated_movie_usecase.dart';

import '../../../domain/entities/movie.dart';
import 'movies_event.dart';

part 'movies_state.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  final GetNowPlayMovieUseCase getNowPlayMovieUseCase;
  final GetPopularMovieUseCase getPopularMovieUseCase;
  final GetTopRatedMovieUseCase getTopRatedMovieUseCase;

  MoviesBloc(
    this.getNowPlayMovieUseCase,
    this.getPopularMovieUseCase,
    this.getTopRatedMovieUseCase,
  ) : super(MoviesInitial()) {
    on<GetNowPlayingEvent>(_getNowPlayingMovies);
    // يعني انا عم نادي على ميثود ينفذلي ياها

    on<GetPopularEvent>(_getPopularMovies);

    on<GetTopRatedEvent>(_getTopRatedMovies);
  }

  FutureOr<void> _getNowPlayingMovies(
      GetNowPlayingEvent event, Emitter<MoviesState> emit) async {
    final result = await getNowPlayMovieUseCase(const NoParameters());
    result.fold(
      (l) => emit(
        state.copyWith(
          nowPlayingState: RequestState.error,
          nowPlayingMessage: l.message,
        ),
      ),
      (r) => emit(
        state.copyWith(
          nowPlayingMovies: r,
          nowPlayingState: RequestState.loaded,
        ),
      ),
    );
  }

  FutureOr<void> _getPopularMovies(
      GetPopularEvent event, Emitter<MoviesState> emit) async {
    final result = await getPopularMovieUseCase(const NoParameters());
    result.fold(
      (l) => emit(
        state.copyWith(
          popularState: RequestState.error,
          popularMessage: l.message,
        ),
      ),
      (r) => emit(
        state.copyWith(
          popularMovies: r,
          popularState: RequestState.loaded,
        ),
      ),
    );
  }

  FutureOr<void> _getTopRatedMovies(
      GetTopRatedEvent event, Emitter<MoviesState> emit) async {
    final result = await getTopRatedMovieUseCase(const NoParameters());
    result.fold(
      (l) => emit(
        state.copyWith(
          topRatedState: RequestState.error,
          topRatedMessage: l.message,
        ),
      ),
      (r) => emit(
        state.copyWith(
          topRatedMovies: r,
          topRatedState: RequestState.loaded,
        ),
      ),
    );
  }
}
