

import 'dart:math';

import 'package:bloc/bloc.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:friendlyeats/src/model/filter.dart';
import 'package:friendlyeats/src/model/restaurant.dart';
import 'package:friendlyeats/src/model/data.dart' as data;
import 'package:friendlyeats/src/model/review.dart';

// import '../blocs.dart';
import 'bloc.dart';

class RestaurantBloc extends Bloc<RestaurantEvent, RestaurantState> {
  RestaurantBloc() : super(RestaurantState.empty());

  @override
  Stream<RestaurantState> mapEventToState(RestaurantEvent event) async* {
    if(event is Loading) {
      yield* _mapLoadingToState();
    } else if(event is GetReviews) {
      yield* _mapGetReviewsToState();
    } else if(event is SetUserName) {
      yield* _mapSetUserNameToState(event.name);
    } else if(event is SetUserId) {
      yield* _mapSetUserIdToState(event.uid);
    } else if(event is SetRestaurant) {
      yield* _mapSetRestaurantToState(event.res);
    } else if(event is AddRandomReviews) {
      yield* _mapAddRandomReviewsToState();
    } else if(event is GetRestaurants) {
      yield* _mapGetRestaurantsToState(event.id);
    }
  }

  Stream<RestaurantState> _mapGetReviewsToState() async* {
    List<Review> reviews = <Review>[];

    reviews = await data.loadCurrentReviews(state.restaurant);

    yield state.update(
      isLoading: false,
      reviews: reviews,
      restaurant: state.restaurant,
        uid: state.uid,
        userName: state.userName,
    );
  }

  Stream<RestaurantState> _mapLoadingToState() async* {
    yield state.update(
        isLoading: true,
        uid: state.uid,
        restaurant: state.restaurant,
        userName: state.userName,
        reviews: state.reviews,
    );
  }

  Stream<RestaurantState> _mapSetUserNameToState(String name) async* {
    yield state.update(
        userName: name,
        uid: state.uid,
        restaurant: state.restaurant,
        reviews: state.reviews,
        isLoading: state.isLoading,
    );
  }

  Stream<RestaurantState> _mapSetUserIdToState(String uid) async* {
    yield state.update(
        uid: uid,
        userName: state.userName,
        reviews: state.reviews,
        restaurant: state.restaurant,
        isLoading: state.isLoading,
    );
  }

  Stream<RestaurantState> _mapSetRestaurantToState(Restaurant res) async* {
    yield state.update(
        restaurant: res,
      isLoading: state.isLoading,
      reviews: state.reviews,
        userName: state.userName,
        uid: state.uid,
    );
  }

  Stream<RestaurantState> _mapGetRestaurantsToState(String id) async* {
    Restaurant restaurant;

    restaurant = await data.getRestaurant(id);

    yield state.update(
        isLoading:state.isLoading,
        restaurant: restaurant,
      reviews: state.reviews,
      userName: state.userName,
      uid: state.uid,
    );
  }

  Stream<RestaurantState> _mapAddRandomReviewsToState() async* {
    final numReviews = Random().nextInt(5) + 5;
    for (var i = 0; i < numReviews; i++) {
      await data.addReview(
        restaurantId: state.restaurant.id,
        review: Review.random(
          userId: state.uid,
          userName: state.userName,
        ),
      );
    }
  }
}