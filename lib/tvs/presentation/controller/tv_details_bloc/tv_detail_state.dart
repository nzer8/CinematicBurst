part of 'tv_detail_bloc.dart';

class TvDetailState extends Equatable {
  const TvDetailState({
    this.tvDetail,
    this.tvDetailState = RequestState.loading,
    this.messageTvDetails = '',

    this.recommendationsTvs = const[],
    this.tvRecommendationsState = RequestState.loading,
    this.tvRecommendationsMessage = '',
  });

  final TvDetails? tvDetail;
  final RequestState tvDetailState;
  final String messageTvDetails;

  final List<RecommendationTvs> recommendationsTvs;
  final RequestState tvRecommendationsState;
  final String tvRecommendationsMessage;

  TvDetailState copyWith({
    TvDetails? tvDetail,
    RequestState? tvDetailState,
    String? messageTvDetails,

    List<RecommendationTvs>? recommendationsTvs,
    RequestState? tvRecommendationsState,
    String? tvRecommendationsMessage,
  }) {
    return TvDetailState(
      tvDetail: tvDetail ?? this.tvDetail,
      tvDetailState: tvDetailState ?? this.tvDetailState,
      messageTvDetails: messageTvDetails ?? this.messageTvDetails,
      recommendationsTvs: recommendationsTvs ?? this.recommendationsTvs,
      tvRecommendationsState: tvRecommendationsState ??
          this.tvRecommendationsState,
      tvRecommendationsMessage: tvRecommendationsMessage ??
          this.tvRecommendationsMessage,
    );
  }

  @override
  List<Object?> get props =>
      [
        tvDetail,
        tvDetailState,
        messageTvDetails,
        recommendationsTvs,
        tvRecommendationsState,
        tvRecommendationsMessage,
      ];
}
