

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:friendlyeats/src/model/filter.dart';
import 'package:friendlyeats/src/model/restaurant.dart';
import 'package:friendlyeats/src/model/data.dart' as data;

import 'bloc.dart';

// import '../blocs.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState.empty());

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is LoadAllRestaurants) {
      yield* _mapLoadAllRestaurantsToState();
    } else if(event is Loading) {
      yield* _mapLoadingToState();
    } else if(event is LoadFilteredRestaurants) {
      yield* _mapLoadFilteredRestaurantsToState();
    } else if(event is SetFilter) {
      yield* _mapSetFilterToState(event.filter);
    }
  }

  Stream<HomeState> _mapLoadAllRestaurantsToState() async* {
    List<Restaurant> restaurants = <Restaurant>[];

    restaurants = await data.loadAllRestaurants_bloc();

    yield state.update(isLoading: false, restaurants: restaurants);
  }

  Stream<HomeState> _mapLoadFilteredRestaurantsToState() async* {
    List<Restaurant> restaurants = <Restaurant>[];

    restaurants = await data.loadFilteredRestaurants_bloc(state.filter);

    yield state.update(isLoading: false, restaurants: restaurants);
  }

  Stream<HomeState> _mapSetFilterToState(Filter filter) async* {
    yield state.update(filter: filter);
  }

  Stream<HomeState> _mapLoadingToState() async* {
    yield state.update(isLoading: true);
  }
}