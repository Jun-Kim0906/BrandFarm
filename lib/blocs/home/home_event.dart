
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:friendlyeats/src/model/filter.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class Loading extends HomeEvent{}

class LoadAllRestaurants extends HomeEvent{}

class LoadFilteredRestaurants extends HomeEvent{}

class SetFilter extends HomeEvent{
  final Filter filter;

  const SetFilter({@required this.filter});

  @override
  String toString() {
    return '''SetFilter{
        filter: $filter,
        ''';
  }
}