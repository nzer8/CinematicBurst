part of 'tvs_bloc.dart';

abstract class TvsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetOnTheAirTvsEvent extends TvsEvent {}

class GetPopularTvsEvent extends TvsEvent {}

class GetTopRatedTvsEvent extends TvsEvent {}
