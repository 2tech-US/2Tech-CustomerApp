part of 'authentication_cubit.dart';

class LoginState extends CubitState {
  LoginState(this.loginRequest);

  final LoginRequest loginRequest;

  // @override
  List<Object> get props => [loginRequest];
}

class RegisterState extends CubitState {
  // @override
  List<Object> get props => [];
}

class ForgotPasswordState extends CubitState {
  // @override
  List<Object> get props => [];
}
