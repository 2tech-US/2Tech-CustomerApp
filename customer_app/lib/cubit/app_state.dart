part of 'app_cubit.dart';

abstract class CubitState {}

class InitialState extends CubitState {
  // @override
  List<Object> get props => [];
}

class ConnectErrorState extends CubitState {
  // @override
  List<Object> get props => [];
}

class AuthenticatedState extends CubitState {
  AuthenticatedState(this.user);

  final User user;

  // @override
  List<Object> get props => [user];
}

class UnauthenticatedState extends CubitState {
  // @override
  List<Object> get props => [];
}

class TimedOutState extends CubitState {
  // @override
  List<Object> get props => [];
}

class FirstOpenState extends CubitState {
  // @override
  List<Object> get props => [];
}
