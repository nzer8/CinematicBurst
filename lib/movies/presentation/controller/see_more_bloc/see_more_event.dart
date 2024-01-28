part of 'see_more_bloc.dart';

abstract class SeeMoreEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SeeMorePopularEvent extends SeeMoreEvent {}

class SeeMoreTopRatedEvent extends SeeMoreEvent {}
