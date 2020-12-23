import 'package:flutter/cupertino.dart';
import 'package:friendlyeats/src/model/filter.dart';
import 'package:friendlyeats/src/model/restaurant.dart';
import 'package:meta/meta.dart';

class HomeState {
  final bool isLoading;
  final List<Restaurant> restaurants;
  final Filter filter;

  HomeState({
    @required this.isLoading,
    @required this.restaurants,
    @required this.filter,
  });

  factory HomeState.empty() {
    return HomeState(
      isLoading: true,
      restaurants: <Restaurant>[],
      filter: Filter(),
    );
  }

  HomeState copyWith({
    bool isLoading,
    List<Restaurant> restaurants,
    Filter filter,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      restaurants: restaurants ?? this.restaurants,
      filter: filter ?? this.filter,
    );
  }

  HomeState update({
    bool isLoading,
    List<Restaurant> restaurants,
    Filter filter,
  }) {
    return copyWith(
      isLoading: isLoading,
      restaurants: restaurants,
      filter: filter,
    );
  }

  @override
  String toString() {
    return '''HomeState{
    isLoading: $isLoading,
    restaurants: ${restaurants.length},
    filter: $filter,
    ''';
  }
}
