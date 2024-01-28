import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/usecase/base_usecase.dart';
import '../../../../core/utils/enums.dart';
import '../../../domain/entities/movie.dart';
import '../../../domain/useCase/get_popular_movie_usecase.dart';
import '../../../domain/useCase/get_top_rated_movie_usecase.dart';

part 'see_more_event.dart';
part 'see_more_state.dart';

class SeeMoreBloc extends Bloc<SeeMoreEvent, SeeMoreState> {
  final GetPopularMovieUseCase seeMorePopularMovieUseCase;
  final GetTopRatedMovieUseCase seeMoreTopRatedMovieUseCase;

  SeeMoreBloc(
    this.seeMorePopularMovieUseCase,
    this.seeMoreTopRatedMovieUseCase,
  ) : super(const SeeMoreState()) {
    on<SeeMorePopularEvent>(_seeMorePopular);
    on<SeeMoreTopRatedEvent>(_seeMoreTopRated);
  }

  FutureOr<void> _seeMorePopular(
      SeeMoreEvent event, Emitter<SeeMoreState> emit) async {
    final result = await seeMorePopularMovieUseCase(const NoParameters());
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

  FutureOr<void> _seeMoreTopRated(
      SeeMoreEvent event, Emitter<SeeMoreState> emit) async {
    final result = await seeMoreTopRatedMovieUseCase(const NoParameters());
    result.fold(
      (l) => emit(
        state.copyWith(
          topRatedState: RequestState.error,
          topRatedMessage: l.message,
        ),
      ),
      (r) => emit(
        state.copyWith(
          topRated: r,
          topRatedState: RequestState.loaded,
        ),
      ),
    );
  }
}
