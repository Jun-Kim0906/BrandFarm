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

// import 'package:bloc/bloc.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:friendlyeats/blocs/blocObserver.dart';

// import 'src/app.dart' deferred as app;
// import 'src/data_repository/user_repository/user_repository.dart';
//
// class PreviewsMain extends StatefulWidget {
//   final UserRepository _userRepository;
//
//   PreviewsMain({Key key, @required UserRepository userRepository})
//       : assert(userRepository != null),
//         _userRepository = userRepository,
//         super(key: key);
//
//   @override
//   _PreviewsMainState createState() =>
//       _PreviewsMainState(_userRepository);
// }
//
// class _PreviewsMainState extends State<PreviewsMain> {
  //
  // Bloc.observer = MyBlocObserver();
  // // Initialize Firebase
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();

  // final Future<void> loadedLibrary = await app.loadLibrary();
  // runApp(
  //   FutureBuilder(
  //     future: loadedLibrary,
  //     builder: (snapshot, context) => app.FriendlyEatsApp(),
  //   ),
  // );

  // final UserRepository userRepository;
  // // Future<void> loadedLibrary;
  // _PreviewsMainState(this.userRepository);
  //
  // @override
  // void initState() {
  //   super.initState();
  //   // getLibrary();
  // }

  // void getLibrary() async {
  //   Future<void> loadedLib = await app.loadLibrary();
  //   if(loadedLib == null) {
  //     print('loadedLib is null\n');
  //   }
  //   setState(() {
  //     loadedLibrary = loadedLib;
  //   });
  //   if(loadedLibrary == null) {
  //     print('loadedLibrary is null\n');
  //   }
  // }

  // void getLibrary() async {
  //   Future<void> loadedLibrary = await app.loadLibrary();
  // }
  //
  // @override
  // Widget build(BuildContext context) {
  //   return FutureBuilder(
  //     // future: loadedLibrary,
  //     future: getLibrary(),
  //     builder: (snapshot, context) => app.FriendlyEatsApp(userRepository: userRepository,),
  //   );
  // }
// }
