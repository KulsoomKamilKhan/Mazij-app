import 'dart:async';
import 'dart:io';
import 'package:Mazaj/data/models/user_model.dart';
import 'package:Mazaj/data/repositories/user_repo.dart';
import 'package:Mazaj/data/repositories/profile_repo.dart';
import 'package:Mazaj/screens/collab/chat/services/database_service.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository _userRepository = UserRepository();
  final ProfileRepository _profileRepository = ProfileRepository();
  AuthenticationBloc() : super(AuthenticationInitial());

  var storage = const FlutterSecureStorage();

  AuthenticationState get initialState => Uninitialized();

  //Event to state conversion logic:
  //defining the events and states related to authentication
  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is Login) {
      yield* mapLogin(event.username, event.password);
    } else if (event is Register) {
      yield* mapRegister(event.user);
    } else if (event is DeleteAcc) {
      yield* mapDelete(event.username, event.password);
    } else if (event is DeleteUser) {
      yield* mapDeleteUser(event.username);
    } else if (event is UpdatePass) {
      yield* mapUpdatePass(event.username, event.email, event.password);
    } else if (event is UpdateAccount) {
      yield* mapUpdateAccount(event.firstname, event.lastname, event.email,
          event.password, event.account_type);
    }
  }

  //Secure storage to store Registration and Login details after authentication
  Future regPersistence(User user) async {
    await storage.write(key: 'login', value: 'true');
    await storage.write(key: 'username', value: user.username);
    await storage.write(key: 'firstname', value: user.first_name);
    await storage.write(key: 'lastname', value: user.last_name);
    await storage.write(key: 'email', value: user.email);
    await storage.write(key: 'accounttype', value: user.account_type);
    await storage.write(key: 'dateofbirth', value: user.date_of_birth);
  }

  Future loginPersistence(User user) async {
    await storage.write(key: 'login', value: 'true');
    await storage.write(key: 'username', value: user.username);
    await storage.write(key: 'firstname', value: user.first_name);
    await storage.write(key: 'lastname', value: user.last_name);
    await storage.write(key: 'email', value: user.email);
    await storage.write(key: 'accounttype', value: user.account_type);
    await storage.write(key: 'dateofbirth', value: user.date_of_birth);
  }

  Stream<AuthenticationState> mapLogin(
      String username, String password) async* {
    yield AuthenticationWait(); //load or wait event called
    try {
      var response = await _userRepository.getUserByusername(
          username); //retrieving password from user and authenticating it
      print("bloc0");
      if (response.passwords.compareTo(password) == 0) {
        print("bloc1");
        var profile = await _profileRepository.getProfileByUsername(username);
        loginPersistence(response);
        await storage.write(key: 'bio', value: profile.bio);
        await storage.write(key: 'profile_pic', value: profile.profile_pic);
        print("bloc2");
        print(response.username);
        print(response.email);
        if ((response.username.compareTo('hwumazijadmin48') == 0) &&
            response.email.compareTo('hwumazij@gmail.com') == 0) {
          print("admin login bloc");
          yield AdminLogin();
        } else {
          yield LoginSuccessful();
        } //if correct, succesfully login
      } else {
        yield const LoginUnsuccessful(
            //if incorrect, redirect back to login page
            error: ('Failed to retrieve user details'));
      }
    } on SocketException {
      //error handling
      yield const RegistrationUnsuccessful(
        error: ('No Internet'),
      );
    } on HttpException {
      yield const RegistrationUnsuccessful(
        error: ('No Service'),
      );
    } on FormatException {
      yield const RegistrationUnsuccessful(
        error: ('No Format Exception'),
      );
    } catch (e) {
      yield AuthenicationError();
    }
  }

  Stream<AuthenticationState> mapRegister(User user) async* {
    yield AuthenticationWait(); //load or wait event called
    try {
      var response = await _userRepository.createUser(
          user); //retrieving user registration details and authenticating user
      if (response) {
        regPersistence(user);
        await storage.write(key: 'bio', value: 'null');
        await storage.write(key: 'profile_pic', value: 'null');
        if ((user.username.compareTo('hwumazijadmin48') == 0) &&
            user.email.compareTo('hwumazij@gmail.com') == 0) {
          print("admin reg bloc");

          yield AdminLogin();
        } else {
          String fullName = user.first_name + ' ' + user.last_name;
          DatabaseService(user.username).updateUserData(fullName);
          print("done");
          yield RegistrationSuccessful();
        } //if user details are valid, register successfully and route to home page
      } else {
        yield const RegistrationUnsuccessful(
            //if user details are invalid, registration fails and redirects back to registration page
            error: ('Failed to create your account'));
      }
    } on SocketException {
      //error handling
      yield const RegistrationUnsuccessful(
        error: ('No Internet'),
      );
    } on HttpException {
      yield const RegistrationUnsuccessful(
        error: ('No Service'),
      );
    } on FormatException {
      yield const RegistrationUnsuccessful(
        error: ('No Format Exception'),
      );
    } catch (e) {
      yield AuthenicationError();
    }
  }

  Stream<AuthenticationState> mapDelete(
      //delete user account
      String username,
      String password) async* {
    yield AuthenticationWait();
    try {
      var response = await _userRepository
          .getUserByusername(username); //delete user account using username
      if (response.passwords.compareTo(password) == 0) {
        //retrieving password and authenticate delete account
        var response2 = await _userRepository.deleteUser(username);
        if (response2) {
          //if correct details provided, delete account
          await storage.deleteAll();
          yield AccountDeleted();
        }
      } else {
        yield AuthenicationError();
      }
    } on SocketException {
      //error handling
      yield const RegistrationUnsuccessful(
        error: ('No Internet'),
      );
    } on HttpException {
      yield const RegistrationUnsuccessful(
        error: ('No Service'),
      );
    } on FormatException {
      yield const RegistrationUnsuccessful(
        error: ('No Format Exception'),
      );
    } catch (e) {
      yield AuthenicationError();
    }
  }

  Stream<AuthenticationState> mapDeleteUser(
      //delete user account
      String username) async* {
    yield AuthenticationWait();
    try {
      var response = await _userRepository.deleteUser(username);
      if (response) {
        await storage.deleteAll();
        yield AccountDeleted();
      } else {
        yield AuthenicationError();
      }
    } on SocketException {
      //error handling
      yield const RegistrationUnsuccessful(
        error: ('No Internet'),
      );
    } on HttpException {
      yield const RegistrationUnsuccessful(
        error: ('No Service'),
      );
    } on FormatException {
      yield const RegistrationUnsuccessful(
        error: ('No Format Exception'),
      );
    } catch (e) {
      yield AuthenicationError();
    }
  }

  Stream<AuthenticationState> mapUpdatePass(
      //Forget password page - update password
      String username,
      String email,
      String password) async* {
    yield AuthenticationWait();
    try {
      var response = await _userRepository.getUserByusername(
          username); //username is primary key and does not change
      if (response.email.compareTo(email) == 0) {
        var user = User(
            username: response.username,
            first_name: response.first_name,
            last_name: response.last_name,
            email: response.email,
            account_type: response.account_type,
            date_of_birth: response.date_of_birth,
            passwords: password);

        var response2 = await _userRepository
            .updateUser(user); //retrieve user details and update password
        if (response2) {
          yield PasswordUpdated(); //if successful, password updated
        }
      } else {
        yield AuthenicationError();
      }
    } on SocketException {
      //error handling
      yield const RegistrationUnsuccessful(
        error: ('No Internet'),
      );
    } on HttpException {
      yield const RegistrationUnsuccessful(
        error: ('No Service'),
      );
    } on FormatException {
      yield const RegistrationUnsuccessful(
        error: ('No Format Exception'),
      );
    } catch (e) {
      yield AuthenicationError();
    }
  }

  Stream<AuthenticationState> mapUpdateAccount(
      //update account details : firstname, lastname, email, password, accountType
      String firstname,
      String lastname,
      String email,
      String password,
      String account_type) async* {
    yield AuthenticationWait();

    try {
      var user = User(
          username: (await storage.read(key: 'username')).toString(),
          first_name: firstname,
          last_name: lastname,
          email: email,
          account_type: account_type,
          date_of_birth: (await storage.read(key: 'dateofbirth')).toString(),
          passwords: password);
      print("validated bloc");
      print(user.account_type);
      var response = await _userRepository
          .updateUser(user); //retrieve user details and update account
      if (response) {
        yield AccountUpdated(); //if successful, account details updated
      }
    } on SocketException {
      //error handling
      yield const RegistrationUnsuccessful(
        error: ('No Internet'),
      );
    } on HttpException {
      yield const RegistrationUnsuccessful(
        error: ('No Service'),
      );
    } on FormatException {
      yield const RegistrationUnsuccessful(
        error: ('No Format Exception'),
      );
    } catch (e) {
      yield AuthenicationError();
    }
  }

  Stream<AuthenticationState> mapGetUser(
      //Forget password page - update password
      String username,
      String email,
      String password) async* {
    yield AuthenticationWait();
    try {
      var response = await _userRepository.getUserByusername(
          username); //username is primary key and does not change
      if (response.email.compareTo(email) == 0) {
        var user = User(
            username: response.username,
            first_name: response.first_name,
            last_name: response.last_name,
            email: response.email,
            account_type: response.account_type,
            date_of_birth: response.date_of_birth,
            passwords: password);

        var response2 = await _userRepository
            .updateUser(user); //retrieve user details and update password
        if (response2) {
          yield PasswordUpdated(); //if successful, password updated
        }
      } else {
        yield AuthenicationError();
      }
    } on SocketException {
      //error handling
      yield const RegistrationUnsuccessful(
        error: ('No Internet'),
      );
    } on HttpException {
      yield const RegistrationUnsuccessful(
        error: ('No Service'),
      );
    } on FormatException {
      yield const RegistrationUnsuccessful(
        error: ('No Format Exception'),
      );
    } catch (e) {
      yield AuthenicationError();
    }
  }
}
