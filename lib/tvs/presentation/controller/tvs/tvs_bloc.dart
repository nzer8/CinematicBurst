import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/tvs/domain/entities/tvs.dart';
import 'package:movies/tvs/domain/useCase/get_on_the_air_tvs.dart';
import 'package:movies/tvs/domain/useCase/get_popular_tvs.dart';
import 'package:movies/tvs/domain/useCase/get_top_rated_tvs.dart';

import '../../../../core/usecase/base_usecase.dart';
import '../../../../core/utils/enums.dart';

part 'tvs_event.dart';
part 'tvs_state.dart';

class TvsBloc extends Bloc<TvsEvent, TvsState> {
  final GetOnTheAirTvsUseCase getOnTheAirTvsUseCase;
  final GetPopularTvsUseCase getPopularTvsUseCase;
  final GetTopRatedTvsUseCase getTopRatedTvsUseCase;

  TvsBloc(
    this.getOnTheAirTvsUseCase,
    this.getPopularTvsUseCase,
    this.getTopRatedTvsUseCase,
  ) : super(const TvsState()) {
    on<GetOnTheAirTvsEvent>(_getOnTheAirTvs);
    // يعني انا عم نادي على ميثود ينفذلي ياها

    on<GetPopularTvsEvent>(_getPopularTvs);

    on<GetTopRatedTvsEvent>(_getTopRatedTvs);
  }

  FutureOr<void> _getOnTheAirTvs(
      GetOnTheAirTvsEvent event, Emitter<TvsState> emit) async {
    final result = await getOnTheAirTvsUseCase(const NoParameters());
    result.fold(
      (l) => emit(
        state.copyWith(
          onTheAirTvState: RequestState.error,
          onTheAirTvMessage: l.message,
        ),
      ),
      (r) => emit(
        state.copyWith(
          onTheAirTv: r,
          onTheAirTvState: RequestState.loaded,
        ),
      ),
    );
  }

  FutureOr<void> _getPopularTvs(
      GetPopularTvsEvent event, Emitter<TvsState> emit) async {
    final result = await getPopularTvsUseCase(const NoParameters());
    result.fold(
      (l) => emit(
        state.copyWith(
          popularTvState: RequestState.error,
          popularTvMessage: l.message,
        ),
      ),
      (r) => emit(
        state.copyWith(
          popularTv: r,
          popularTvState: RequestState.loaded,
        ),
      ),
    );
  }

  FutureOr<void> _getTopRatedTvs(
      GetTopRatedTvsEvent event, Emitter<TvsState> emit) async {
    final result = await getTopRatedTvsUseCase(const NoParameters());
    result.fold(
      (l) => emit(
        state.copyWith(
          topRatedTvState: RequestState.error,
          topRatedTvMessage: l.message,
        ),
      ),
      (r) => emit(
        state.copyWith(
          topRatedTv: r,
          topRatedTvState: RequestState.loaded,
        ),
      ),
    );
  }
}
