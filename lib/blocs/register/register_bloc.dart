import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:friendlyeats/blocs/register/bloc.dart';
import 'package:friendlyeats/src/data_repository/user_repository/user_repository.dart';
import 'package:friendlyeats/src/widgets/validators.dart';

import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final UserRepository _userRepository;
  RegisterBloc({@required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(RegisterState.initial());

  // RegisterBloc({@required UserRepository userRepository})
  //     : assert(userRepository != null),
  //       _userRepository = userRepository;
  //
  // @override
  // RegisterState get initialState => RegisterState.initial();

  @override
  Stream<Transition<RegisterEvent, RegisterState>> transformEvents(
      Stream<RegisterEvent> events,
      TransitionFunction<RegisterEvent, RegisterState> transitionFn,
      ) {
    final nonDebounceStream = events.where((event) {
      return (event is! RegisterEmailChanged && event is! RegisterPasswordChanged);
    });
    final debounceStream = events.where((event) {
      return (event is RegisterEmailChanged || event is RegisterPasswordChanged);
    }).debounceTime(Duration(milliseconds: 300));
    return super.transformEvents(
      nonDebounceStream.mergeWith([debounceStream]),
      transitionFn,
    );
  }

  @override
  Stream<RegisterState> mapEventToState(
      RegisterEvent event,
      ) async* {
    if (event is RegisterEmailChanged) {
      yield* _mapRegisterEmailChangedToState(event.email);
    } else if (event is RegisterPasswordChanged) {
      yield* _mapRegisterPasswordChangedToState(event.password);
    } else if (event is RegisterConfirmPasswordChanged) {
      yield* _mapRegisterConfirmPasswordChangedToState(event.password, event.confirmPassword);
    } else if (event is RegisterNameChanged) {
      yield* _mapRegisterNameChangedToState(event.name);
    } else if (event is RegisterSubmitted) {
      yield* _mapRegisterSubmittedToState(event.email, event.password, event.name);
    }
  }

  Stream<RegisterState> _mapRegisterEmailChangedToState(String email) async* {
    yield state.update(
      isEmailValid: Validators.isValidEmail(email),
    );
  }

  Stream<RegisterState> _mapRegisterPasswordChangedToState(String password) async* {
    yield state.update(
      isPasswordValid: Validators.isValidPassword(password),
    );
  }

  Stream<RegisterState> _mapRegisterConfirmPasswordChangedToState(String password, String confirmPassword) async* {
    yield state.update(isSame: password == confirmPassword);

   // bool judge;
   // if (password == state.password) {
   //   judge = true;
   // } else if (password == null || password != state.password) {
   //   judge = false;
   // }
   // yield state.update(
   //   confirmPassword: password,
   //   isPasswordConfirmed: judge,
   // );
  }

  Stream<RegisterState> _mapRegisterNameChangedToState(String name) async* {
    yield state.update(
      name: name,
    );
  }


  Stream<RegisterState> _mapRegisterSubmittedToState(
      String email,
      String password,
      String name,
      ) async* {
    yield RegisterState.loading();
    try {
      await _userRepository.signUp(
        email: email,
        password: password,
      );

      String uid = (await UserRepository().getUser()).uid;

      await FirebaseFirestore.instance.collection("User").doc(uid).set({
        'bgUrl': "",
        'fcmToken': '',
        "uid": uid,
        "email": (await UserRepository().getUser()).email,
        "name": name,
      });

      yield RegisterState.success();
    } catch (_) {
      yield RegisterState.failure();
    }
  }
}
