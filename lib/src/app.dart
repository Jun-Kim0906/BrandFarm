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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friendlyeats/blocs/blocs.dart';
import 'package:friendlyeats/blocs/restaurant/bloc.dart';

import 'home_page.dart';
import 'restaurant_page.dart';

class FriendlyEatsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FriendlyEats',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case RestaurantPage.route:
            final RestaurantPageArguments arguments = settings.arguments;
            return MaterialPageRoute(
                builder: (context) => BlocProvider<RestaurantBloc>(
                    create: (BuildContext context) => RestaurantBloc(),
                    child: RestaurantPage(
                      restaurantId: arguments.id,
                    )));
            break;
          default:
            // return MaterialPageRoute(
            //     builder: (context) => RestaurantPage(
            //           restaurantId: 'lV81npEeboEActMpUJjn',
            //         ));
            // Everything defaults to home, but maybe we want a custom 404 here
            return MaterialPageRoute(
                builder: (context) => BlocProvider<HomeBloc>(
                      create: (BuildContext context) => HomeBloc(),
                      child: HomePage(),
                    ));
        }
      },
    );
  }
}
