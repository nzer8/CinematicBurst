part of 'see_more_tv_bloc.dart';

abstract class SeeMoreTvEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SeeMorePopularTvEvent extends SeeMoreTvEvent {}

class SeeMoreTopRatedTvEvent extends SeeMoreTvEvent {}
