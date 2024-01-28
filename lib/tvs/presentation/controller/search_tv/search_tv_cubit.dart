import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/tvs/domain/useCase/get_search_tv_usecase.dart';
import 'package:movies/tvs/presentation/controller/search_tv/search_tv_state.dart';

class SearchTvCubit extends Cubit<SearchTvState> {
  SearchTvCubit(
    this.searchTvUseCase,
  ) : super(SearchTvsInitial());

  final SearchTvUseCase searchTvUseCase;
  String? query;
  bool hasSearchResults = false; // Add this flag
  String? data;

  Future<void> fetchSearchTv({required String query}) async {
    emit(SearchTvsLoading());
    final result = await searchTvUseCase(SearchTvsParams(query: query));
    result.fold(
      (failure) {
        emit(SearchTvsFailure(failure.message));
      },
      (tv) {
        emit(SearchTvsSuccess(tv));
      },
    );
  }
}
