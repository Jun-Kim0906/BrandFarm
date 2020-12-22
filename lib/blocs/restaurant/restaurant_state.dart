import 'package:flutter/cupertino.dart';
import 'package:friendlyeats/src/model/filter.dart';
import 'package:friendlyeats/src/model/restaurant.dart';
import 'package:friendlyeats/src/model/review.dart';
import 'package:meta/meta.dart';

class RestaurantState {
  final bool isLoading;
  final List<Review> reviews;
  final Restaurant restaurant;
  final String userName;
  final String uid;

  RestaurantState(
      {@required this.isLoading,
        @required this.reviews,
        @required this.restaurant,
        @required this.userName,
        @required this.uid,
      });

  factory RestaurantState.empty() {
    return RestaurantState(
      isLoading: true,
      reviews: <Review>[],
      restaurant: Restaurant(),
      userName: '',
      uid: '',
    );
  }

  RestaurantState copyWith({
    bool isLoading,
    List<Review> reviews,
    Restaurant restaurant,
    String userName,
    String uid,
  }) {
    return RestaurantState(
      isLoading: isLoading ?? this.isLoading,
        reviews: reviews ?? this.reviews,
      restaurant: restaurant ?? this.restaurant,
      userName: userName ?? this.userName,
      uid: uid ?? this.uid,
    );
  }

  RestaurantState update({
     bool isLoading,
     List<Review> reviews,
     Restaurant restaurant,
     String userName,
     String uid,
  }) {
    return copyWith(
      isLoading: isLoading,
        reviews: reviews,
      restaurant: restaurant,
      userName: userName,
      uid: uid,
    );
  }

  @override
  String toString() {
    return '''RestaurantState{
    isLoading: $isLoading,
    reviews: ${reviews.length},
    restaurant: $restaurant,
    userName: $userName,
    uid: $uid,
    ''';
  }
}
