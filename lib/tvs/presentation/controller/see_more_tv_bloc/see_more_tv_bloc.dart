import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/tvs/domain/useCase/get_popular_tvs.dart';
import 'package:movies/tvs/domain/useCase/get_top_rated_tvs.dart';

import '../../../../core/usecase/base_usecase.dart';
import '../../../../core/utils/enums.dart';
import '../../../domain/entities/tvs.dart';

part 'see_more_tv_event.dart';

part 'see_more_tv_state.dart';

class SeeMoreTvBloc extends Bloc<SeeMoreTvEvent, SeeMoreTvState> {
  final GetPopularTvsUseCase seeMorePopularTvUseCase;
  final GetTopRatedTvsUseCase seeMoreTopRatedTvUseCase;

  SeeMoreTvBloc(this.seeMorePopularTvUseCase, this.seeMoreTopRatedTvUseCase)
      : super(const SeeMoreTvState()) {
    on<SeeMorePopularTvEvent>(_seeMorePopularTv);
    on<SeeMoreTopRatedTvEvent>(_seeMoreTopRatedTv);
  }

  FutureOr<void> _seeMorePopularTv(
      SeeMorePopularTvEvent event, Emitter<SeeMoreTvState> emit) async {
    final result = await seeMorePopularTvUseCase(const NoParameters());
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

  FutureOr<void> _seeMoreTopRatedTv(
      SeeMoreTopRatedTvEvent event, Emitter<SeeMoreTvState> emit) async {
    final result = await seeMoreTopRatedTvUseCase(const NoParameters());
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
