part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  //Equatable  overrides == and hashCode and helps us with data/object comparison
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
  //props property decides which objects we should consider for object comparison
}

class Login extends AuthenticationEvent {
  //provide the Login state of Authentication bloc with username and password
  final String username;
  final String password;
  const Login({required this.username, required this.password});
}

class Register extends AuthenticationEvent {
  //provide the Register state of authentication bloc with user details
  final user;
  const Register({
    required this.user,
  });
}

class DeleteAcc extends AuthenticationEvent {
  //provide the Delete state of authentication bloc with username and password
  final String username;
  final String password;
  const DeleteAcc({required this.username, required this.password});
}

class DeleteUser extends AuthenticationEvent {
  //provide the Delete state of authentication bloc with username and password
  final String username;
  const DeleteUser({required this.username});
}

class UpdatePass extends AuthenticationEvent {
  //provide the UpdatePassword state of authentication bloc with username and updated password
  final String username;
  final String email;
  final String password;
  const UpdatePass({required this.username, required this.email, required this.password});
}

class UpdateAccount extends AuthenticationEvent {
  //provide the Update Account state of authentication bloc with user details (except username and dob)
  final String firstname;
  final String lastname;
  final String email;
  final String password;
  final String account_type;
  const UpdateAccount(
      {required this.firstname,
      required this.lastname,
      required this.email,
      required this.password,
      required this.account_type});
}
