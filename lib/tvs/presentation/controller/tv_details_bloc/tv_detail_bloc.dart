import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/movies/domain/useCase/get_recommendations_movie_usecase.dart';
import 'package:movies/tvs/domain/entities/recommendation_tvs.dart';
import 'package:movies/tvs/domain/entities/tv_detail.dart';

import '../../../../core/utils/enums.dart';
import '../../../domain/useCase/get_recommendations_tv_usecase.dart';
import '../../../domain/useCase/get_tv_details_usecase.dart';

part 'tv_detail_event.dart';
part 'tv_detail_state.dart';

class TvDetailBloc extends Bloc<TvDetailEvent, TvDetailState> {
  TvDetailBloc(this.getTvDetailsUesCase, this.getRecommendationsTvUseCase)
      : super(const TvDetailState()) {
    on<GetTvDetailsEvent>(_getTvDetailsEvent);
    on<GetTvRecommendationEvent>(_getTvRecommendationEvent);
  }
  final GetTvDetailsUesCase getTvDetailsUesCase;
  final GetRecommendationsTvUseCase getRecommendationsTvUseCase;

  FutureOr<void> _getTvDetailsEvent(
      GetTvDetailsEvent event, Emitter<TvDetailState> emit) async {
    final result =
        await getTvDetailsUesCase(TvDetailsParameters(tvId: event.id));
    result.fold(
      (l) => emit(state.copyWith(
        tvDetailState: RequestState.error,
        messageTvDetails: l.message,
      )),
      (r) => emit(
        state.copyWith(
          tvDetail: r,
          tvDetailState: RequestState.loaded,
        ),
      ),
    );
  }

  FutureOr<void> _getTvRecommendationEvent(
      GetTvRecommendationEvent event, Emitter<TvDetailState> emit) async {
    final result = await getRecommendationsTvUseCase(
        TvRecommendationParameters(tvId: event.id));
    print(result);
    result.fold(
      (l) => emit(state.copyWith(
        tvRecommendationsState: RequestState.error,
        tvRecommendationsMessage: l.message,
      )),
      (r) => emit(
        state.copyWith(
          recommendationsTvs: r,
          tvRecommendationsState: RequestState.loaded,
        ),
      ),
    );
  }
}
