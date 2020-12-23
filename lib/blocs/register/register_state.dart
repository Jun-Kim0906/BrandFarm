import 'package:meta/meta.dart';

@immutable
class RegisterState {
  final bool isEmailValid;
  final bool isPasswordValid;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;
  final bool isPasswordConfirmed;
  final bool isSame;
  final String password;
  final String confirmPassword;
  final String name;

  bool get isFormValid =>
      isEmailValid && isPasswordValid && isPasswordConfirmed && isSame;

  RegisterState({
    @required this.isEmailValid,
    @required this.isPasswordValid,
    @required this.isSubmitting,
    @required this.isSuccess,
    @required this.isFailure,
    @required this.isPasswordConfirmed,
    @required this.isSame,
    @required this.password,
    @required this.confirmPassword,
    @required this.name,
  });

  factory RegisterState.initial() {
    return RegisterState(
      isEmailValid: true,
      isPasswordValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
      isPasswordConfirmed: true,
      isSame: true,
      password: "",
      confirmPassword: "",
      name: "",
    );
  }

  factory RegisterState.loading() {
    return RegisterState(
      isEmailValid: true,
      isPasswordValid: true,
      isSubmitting: true,
      isSuccess: false,
      isFailure: false,
      isPasswordConfirmed: true,
      isSame: true,
      password: "",
      confirmPassword: "",
      name: "",
    );
  }

  factory RegisterState.failure() {
    return RegisterState(
      isEmailValid: true,
      isPasswordValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: true,
      isPasswordConfirmed: true,
      isSame: true,
      password: "",
      confirmPassword: "",
      name: "",
    );
  }

  factory RegisterState.success() {
    return RegisterState(
      isEmailValid: true,
      isPasswordValid: true,
      isSubmitting: false,
      isSuccess: true,
      isFailure: false,
      isPasswordConfirmed: true,
      isSame: true,
      password: "",
      confirmPassword: "",
      name: "",
    );
  }

  RegisterState update({
    bool isEmailValid,
    bool isPasswordValid,
    bool isPasswordConfirmed,
    bool isSame,
    String password,
    String confirmPassword,
    String name,
  }) {
    return copyWith(
      isEmailValid: isEmailValid,
      isPasswordValid: isPasswordValid,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
      isPasswordConfirmed: isPasswordConfirmed,
      isSame: isSame,
      password: password,
      confirmPassword: confirmPassword,
      name: name,
    );
  }

  RegisterState copyWith({
    bool isEmailValid,
    bool isPasswordValid,
    bool isSubmitEnabled,
    bool isSubmitting,
    bool isSuccess,
    bool isFailure,
    bool isPasswordConfirmed,
    bool isSame,
    String password,
    String confirmPassword,
    String name,
  }) {
    return RegisterState(
        isEmailValid: isEmailValid ?? this.isEmailValid,
        isPasswordValid: isPasswordValid ?? this.isPasswordValid,
        isSubmitting: isSubmitting ?? this.isSubmitting,
        isSuccess: isSuccess ?? this.isSuccess,
        isFailure: isFailure ?? this.isFailure,
        isPasswordConfirmed: isPasswordConfirmed ?? this.isPasswordConfirmed,
        isSame: isSame ?? this.isSame,
        password: password ?? this.password,
        confirmPassword: confirmPassword ?? this.confirmPassword,
        name: name ?? this.name);
  }

  @override
  String toString() {
    return '''RegisterState {
      isEmailValid: $isEmailValid,
      isPasswordValid: $isPasswordValid,
      isSubmitting: $isSubmitting,
      isSuccess: $isSuccess,
      isFailure: $isFailure,
      isPasswordConfirmed : $isPasswordConfirmed,
      isSame : $isSame,
      password : $password,
      confirmPassword : $confirmPassword,
      name : $name,
    }''';
  }
}
