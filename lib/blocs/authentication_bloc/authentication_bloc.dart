import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:friendlyeats/src/data_repository/user_repository/user_repository.dart';
import 'package:friendlyeats/src/model/user_model/user_model.dart';
import 'package:friendlyeats/src/utils/user_util/user_util.dart';
import 'package:meta/meta.dart';


part 'authentication_event.dart';

part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository _userRepository;
  AuthenticationBloc({@required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(AuthenticationInitial());

  // AuthenticationBloc({@required UserRepository userRepository})
  //     : assert(userRepository != null),
  //       _userRepository = userRepository;
  //
  // @override
  // AuthenticationState get initialState => AuthenticationInitial();

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AuthenticationStarted) {
      yield* _mapAuthenticationStartedToState();
    } else if (event is AuthenticationLoggedIn) {
      yield* _mapAuthenticationLoggedInToState();
    } else if (event is AuthenticationLoggedOut) {
      yield* _mapAuthenticationLoggedOutToState();
    }
  }

  Stream<AuthenticationState> _mapAuthenticationStartedToState() async* {
    final isSignedIn = await _userRepository.isSignedIn();
    if (isSignedIn) {
//      final name = (await _userRepository.getUser()).email;
      yield* _mapAuthenticationLoggedInToState();
    } else {
      yield AuthenticationFailure();
    }
  }

  Stream<AuthenticationState> _mapAuthenticationLoggedInToState() async* {
//    yield AuthenticationSuccess((await _userRepository.getUser()).email);
    try {
      UserUtil.setUser(CredentialUser.fromSnapshot(await FirebaseFirestore.instance
          .collection('User')
          .doc((await UserRepository().getUser()).uid)
          .get()));
      print('Login User Name : ' + UserUtil.getUser().name);
      yield AuthenticationSuccess(UserUtil.getUser().name);
    } catch (e) {
      yield AuthenticationFailure();
    }
  }

  Stream<AuthenticationState> _mapAuthenticationLoggedOutToState() async* {
    yield AuthenticationFailure();
    _userRepository.signOut();
  }
}
