part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

//States represent the information to be processed by any widget

//Uninitialized state represents the state before authentication starts
class Uninitialized extends AuthenticationState {
  @override
  String toString() => 'Uninitialized';
}

//Initially autenticating state
class AuthenticationInitial extends AuthenticationState {}

//If Login is successful, we yield the following state
class LoginSuccessful extends AuthenticationState {}

//If Login is unsuccessful, we yield the following state
class LoginUnsuccessful extends AuthenticationState {
  final error;
  const LoginUnsuccessful({this.error});
}

//If Registeration is successful, we yield the following state
class RegistrationSuccessful extends AuthenticationState {}

//If Registeration is unsuccessful, we yield the following state
class RegistrationUnsuccessful extends AuthenticationState {
  final error;
  const RegistrationUnsuccessful({this.error});
}

//Loading or the 'Wait' state that is yielded when authenticating Login or Registration
class AuthenticationWait extends AuthenticationState {}

//Error state that is yielded when any error occurs during the resitration/login processess
class AuthenicationError extends AuthenticationState {}

//State yielded when deleting an account
class AccountDeleted extends AuthenticationState {}

//State yielded when updating the password of an account
class PasswordUpdated extends AuthenticationState {}

//State yielded when updating user details of an account
class AccountUpdated extends AuthenticationState {}

class AdminLogin extends AuthenticationState {}
