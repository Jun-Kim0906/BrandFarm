// Copyright 2020 Google LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:cloud_firestore/cloud_firestore.dart';

import './filter.dart';
import './restaurant.dart';
import './review.dart';

// This is the file that Codelab users will primarily work on.

Future<void> addRestaurant(Restaurant restaurant) {
  final restaurants = FirebaseFirestore.instance.collection('restaurants');
  return restaurants.add({
    'avgRating': restaurant.avgRating,
    'category': restaurant.category,
    'city': restaurant.city,
    'name': restaurant.name,
    'numRatings': restaurant.numRatings,
    'photo': restaurant.photo,
    'price': restaurant.price,
  });
}

Future<List<Restaurant>> loadAllRestaurants_bloc() async {
  List<Restaurant> res = [];
  QuerySnapshot querySnapshot = await FirebaseFirestore.instance
      .collection('restaurants')
      .orderBy('avgRating', descending: true)
      .limit(50)
      .get();
  querySnapshot.docs.forEach((element) {
    res.add(Restaurant.fromSnapshot(element));
  });
  return res;
}

Future<List<Review>> loadCurrentReviews(Restaurant restaurant) async {
  List<Review> reviews = [];
  QuerySnapshot querySnapshot = await restaurant.reference
      .collection('ratings')
      .orderBy('timestamp', descending: true)
      .get();
  querySnapshot.docs.forEach((element) {
    reviews.add(Review.fromSnapshot(element));
  });
  return reviews;
}

Future<Restaurant> getRestaurant(String restaurantId) {
  return FirebaseFirestore.instance
      .collection('restaurants')
      .doc(restaurantId)
      .get()
      .then((DocumentSnapshot doc) => Restaurant.fromSnapshot(doc));
}

Future<void> addReview({String restaurantId, Review review}) {
  final restaurant =
  FirebaseFirestore.instance.collection('restaurants').doc(restaurantId);
  final newReview = restaurant.collection('ratings').doc();

  return FirebaseFirestore.instance.runTransaction((Transaction transaction) {
    return transaction
        .get(restaurant)
        .then((DocumentSnapshot doc) => Restaurant.fromSnapshot(doc))
        .then((Restaurant fresh) {
      final newRatings = fresh.numRatings + 1;
      final newAverage =
          ((fresh.numRatings * fresh.avgRating) + review.rating) / newRatings;

      transaction.update(restaurant, {
        'numRatings': newRatings,
        'avgRating': newAverage,
      });

      transaction.set(newReview, {
        'rating': review.rating,
        'text': review.text,
        'userName': review.userName,
        'timestamp': review.timestamp ?? FieldValue.serverTimestamp(),
        'userId': review.userId,
      });
    });
  });
}

Future<List<Restaurant>> loadFilteredRestaurants_bloc(Filter filter) async {
  List<Restaurant> res = [];
  QuerySnapshot querySnapshot;
  if (filter.category != null) {
    querySnapshot = await FirebaseFirestore.instance
        .collection('restaurants')
        .where('category', isEqualTo: filter.category)
        .orderBy(filter.sort ?? 'avgRating', descending: true)
        .limit(50)
        .get();
  }
  if (filter.city != null) {
    querySnapshot = await FirebaseFirestore.instance
        .collection('restaurants')
        .where('city', isEqualTo: filter.city)
        .orderBy(filter.sort ?? 'avgRating', descending: true)
        .limit(50)
        .get();
  }
  if (filter.price != null) {
    querySnapshot = await FirebaseFirestore.instance
        .collection('restaurants')
        .where('price', isEqualTo: filter.price)
        .orderBy(filter.sort ?? 'avgRating', descending: true)
        .limit(50)
        .get();
  }

  querySnapshot.docs.forEach((element) {
    res.add(Restaurant.fromSnapshot(element));
  });
  return res;
}

void addRestaurantsBatch(List<Restaurant> restaurants) {
  restaurants.forEach((Restaurant restaurant) {
    addRestaurant(restaurant);
  });
}
