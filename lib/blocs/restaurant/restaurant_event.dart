
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
//import 'package:friendlyeats/src/model/filter.dart';
import 'package:friendlyeats/src/model/restaurant.dart';

abstract class RestaurantEvent extends Equatable {
  const RestaurantEvent();

  @override
  List<Object> get props => [];
}

class Loading extends RestaurantEvent{}

class SetUserName extends RestaurantEvent{
  final String name;

  const SetUserName({@required this.name});

  @override
  String toString() {
    return '''SetUserName{
        name: $name,
        ''';
  }
}
class SetUserId extends RestaurantEvent{
  final String uid;

  const SetUserId({@required this.uid});

  @override
  String toString() {
    return '''SetUserId{
        uid: $uid,
        ''';
  }
}

class GetReviews extends RestaurantEvent{}

class SetRestaurant extends RestaurantEvent{
  final Restaurant res;

  const SetRestaurant({@required this.res});

  @override
  String toString() {
    return '''SetRestaurant{
        res: $res,
        ''';
  }
}

class AddRandomReviews extends RestaurantEvent{}