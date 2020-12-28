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

import 'dart:async';
import 'dart:math';

//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friendlyeats/blocs/blocs.dart';
import 'package:friendlyeats/src/chatting.dart';
import 'package:friendlyeats/src/connectivity.dart';
import 'package:friendlyeats/src/fcm.dart';
import 'package:friendlyeats/src/geolocator.dart';
import 'package:friendlyeats/src/widgets/alert_dialog/alert_dialog.dart';

import 'restaurant_page.dart';
import 'model/data.dart' as data;
import 'model/filter.dart';
import 'model/restaurant.dart';
import 'widgets/empty_list.dart';
import 'widgets/filter_bar.dart';
import 'widgets/grid.dart';
import 'widgets/dialogs/filter_select.dart';

class HomePage extends StatefulWidget {
  static const route = '/';

  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeBloc _homeBloc;

  @override
  void initState() {
    super.initState();
    _homeBloc = BlocProvider.of<HomeBloc>(context);
    _homeBloc.add(LoadAllRestaurants());
  }

  List<Restaurant> _currentSubscription = [];
  Future<void> _onAddRandomRestaurantsPressed() async {
    final numReviews = Random().nextInt(10) + 20;

    final restaurants = List.generate(numReviews, (_) => Restaurant.random());
    data.addRestaurantsBatch(restaurants);
    _homeBloc.add(LoadAllRestaurants());
  }

  Future<HomeState> _onFilterBarPressed(HomeState state) async {
    final filter = await showDialog<Filter>(
      context: context,
      builder: (_) => FilterSelectDialog(filter: state.filter),
    );
    if (filter != null) {
      _homeBloc.add(Loading());
      _homeBloc.add(SetFilter(filter: filter));

      if (filter.isDefault) {
        _homeBloc.add(LoadAllRestaurants());
        _currentSubscription = state.restaurants;
      } else {
        _homeBloc.add(LoadFilteredRestaurants());
        _currentSubscription = state.restaurants;
      }
    }
    return state;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          _currentSubscription = state.restaurants;
          return Scaffold(
            appBar: AppBar(
              leading: Icon(Icons.restaurant),
              title: Text('FriendlyEats'),
              actions: [
                IconButton(
                    icon: Icon(Icons.location_on, color: Colors.white,),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => GpsScreen()),
                      );
                    }
                ),
                IconButton(
                    icon: Icon(Icons.wifi, color: Colors.white,),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ConnectivityPage()),
                      );
                    }
                ),
                IconButton(
                    icon: Icon(Icons.logout, color: Colors.white,),
                    onPressed: (){
                      showAlertDialog(context);
                    }
                ),
                IconButton(
                    icon: Icon(Icons.notification_important, color: Colors.white,),
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => FCM()),
                      );
                    }
                ),
                IconButton(
                    icon: Icon(Icons.chat, color: Colors.white,),
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ChatScreen()),
                      );
                    }
                ),
              ],
              bottom: PreferredSize(
                preferredSize: Size(320, 48),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(6, 0, 6, 4),
                  child: FilterBar(
                    filter: state.filter,
                    onPressed: () => _onFilterBarPressed(state),
                  ),
                ),
              ),
            ),
            body: Center(
              child: Container(
                constraints: BoxConstraints(maxWidth: 1280),
                child: state.isLoading
                    ? CircularProgressIndicator()
                    : state.restaurants.isNotEmpty
                    ? RestaurantGrid(
                    restaurants: state.restaurants,
                    onRestaurantPressed: (id) {
                      // TODO: Add deep links on web
                      Navigator.pushNamed(context, RestaurantPage.route,
                          arguments: RestaurantPageArguments(id: id));
                    })
                    : EmptyListView(
                  child: Text('FriendlyEats has no restaurants yet!'),
                  onPressed: _onAddRandomRestaurantsPressed,
                ),
              ),
            ),
          );
        }
    );
  }
}
