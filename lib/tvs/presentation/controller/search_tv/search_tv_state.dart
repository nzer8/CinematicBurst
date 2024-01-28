import 'package:movies/tvs/domain/entities/search_tv.dart';

abstract class SearchTvState {}

class SearchTvsInitial extends SearchTvState {}

class SearchTvsLoading extends SearchTvState {}

class SearchTvsSuccess extends SearchTvState {
  final List<SearchTvs> tv;

  SearchTvsSuccess(this.tv);
}

class SearchTvsFailure extends SearchTvState {
  final String errMessage;

  SearchTvsFailure(this.errMessage);
}
