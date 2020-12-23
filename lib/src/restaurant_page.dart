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

//import 'dart:async';
import 'dart:math';

//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friendlyeats/blocs/restaurant/bloc.dart';
import 'package:sliver_fab/sliver_fab.dart';

import 'widgets/empty_list.dart';
import 'model/data.dart' as data;
import 'model/restaurant.dart';
import 'model/review.dart';
import 'widgets/app_bar.dart';
import 'widgets/review.dart';
import 'widgets/dialogs/review_create.dart';

class RestaurantPage extends StatefulWidget {
  static const route = '/restaurant';

  final String _restaurantId;

  RestaurantPage({Key key, String restaurantId})
      : _restaurantId = restaurantId,
        super(key: key);

  @override
  _RestaurantPageState createState() =>
      _RestaurantPageState(_restaurantId);
}

class _RestaurantPageState extends State<RestaurantPage> {
  RestaurantBloc _resBloc;
  String restaurantId;
  List<Review> _currentReviewSubscription = [];

  @override
  void initState() {
    super.initState();
    _resBloc = BlocProvider.of<RestaurantBloc>(context);
  }

  _RestaurantPageState(this.restaurantId) {
    FirebaseAuth.instance
        .signInAnonymously()
        .then((UserCredential userCredential) {
      data.getRestaurant(restaurantId).then((Restaurant restaurant) {
        // _currentReviewSubscription?.cancel();

        if (userCredential.user.displayName == null ||
            userCredential.user.displayName.isEmpty) {
          _resBloc.add(SetUserName(name: 'Anonymous (${kIsWeb ? "Web" : "Mobile"})'));
        } else {
          _resBloc.add(SetUserName(name: userCredential.user.displayName));
        }
        _resBloc.add(SetRestaurant(res: restaurant));
        _resBloc.add(SetUserId(uid: userCredential.user.uid));
        _resBloc.add(GetReviews());
      });
    });
  }

  void _onCreateReviewPressed(BuildContext context, RestaurantState state) async {
    final newReview = await showDialog<Review>(
      context: context,
      builder: (_) => ReviewCreateDialog(
        userId: state.uid,
        userName: state.userName,
      ),
    );
    if (newReview != null) {
      // Save the review
      await data.addReview(
        restaurantId: state.restaurant.id,
        review: newReview,
      );
    }
    _resBloc.add(GetReviews());
  }

  void _onAddRandomReviewsPressed(RestaurantState state) async {
    // Await adding a random number of random reviews
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
    _resBloc.add(GetReviews());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RestaurantBloc, RestaurantState>(
      builder: (context, state) {
        _currentReviewSubscription = state.reviews;
        return state.isLoading
            ? Center(child: CircularProgressIndicator())
            : Scaffold(
          body: Builder(
            builder: (context) => SliverFab(
              floatingWidget: FloatingActionButton(
                tooltip: 'Add a review',
                backgroundColor: Colors.amber,
                child: Icon(Icons.add),
                onPressed: () => _onCreateReviewPressed(context, state),
              ),
              floatingPosition: FloatingPosition(right: 16),
              expandedHeight: RestaurantAppBar.appBarHeight,
              slivers: <Widget>[
                RestaurantAppBar(
                  restaurant: state.restaurant,
                  onClosePressed: () => Navigator.pop(context),
                ),
                state.reviews.isNotEmpty
                    ? SliverPadding(
                  padding: EdgeInsets.fromLTRB(16, 24, 16, 8),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate(state.reviews
                        .map((Review review) =>
                        RestaurantReview(review: review))
                        .toList()),
                  ),
                )
                    : SliverFillRemaining(
                  hasScrollBody: false,
                  child: EmptyListView(
                    child: Text('${state.restaurant.name} has no reviews.'),
                    onPressed: () => _onAddRandomReviewsPressed(state),
                  ),
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}

class RestaurantPageArguments {
  final String id;

  RestaurantPageArguments({this.id});
}
