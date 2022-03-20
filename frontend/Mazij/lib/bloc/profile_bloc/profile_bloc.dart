import 'dart:io';
import 'package:Mazaj/data/models/profile_model.dart';
import 'package:Mazaj/data/repositories/profile_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:meta/meta.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository _profileRepo = ProfileRepository();
  ProfileBloc() : super(ProfileInitial());

  var storage = const FlutterSecureStorage();

  @override
  Stream<ProfileState> mapEventToState(
    ProfileEvent event,
  ) async* {
    if (event is UpdateProfile) {
      yield* mapUpdateProfile(event.bio, event.profile_pic);
    }
  }

  Stream<ProfileState> mapUpdateProfile(String bio, String profile_pic) async* {
    yield ProfileLoading();
    try {
      var profile = Profile(
          username: (await storage.read(key: 'username')).toString(),
          bio: bio,
          account_type: (await storage.read(key: 'accounttype')).toString(),
          profile_pic: profile_pic);

      var response = await _profileRepo.UpdateProfile(profile);
      if (response) {
        await storage.write(key: 'bio', value: bio);
        await storage.write(key: 'profile_pic', value: profile_pic);
        yield ProfileUpdated();
      }
    } on SocketException {
      yield const ProfileError(
        error: ('No Internet'),
      );
    } on HttpException {
      yield const ProfileError(
        error: ('No Service'),
      );
    } on FormatException {
      yield const ProfileError(
        error: ('No Format Exception'),
      );
    } catch (e) {
      yield ProfileError(error: ('Check username'));
    }
  }

  // Stream<ProfileState> mapUpdateProfilePic(String profile_pic) async* {
  //   yield ProfileLoading();
  //   try {
  //     var profile = Profile(
  //         username: (await storage.read(key: 'username')).toString(),
  //         bio: '',
  //         account_type: (await storage.read(key: 'accounttype')).toString(),
  //         profile_pic: profile_pic);

  //     var response = await _profileRepo.UpdateProfilePic(profile);
  //     if (response) {
  //       await storage.write(key: '', value: profile_pic);
  //       yield ProfilePicUpdated();
  //     }
  //   } on SocketException {
  //     yield const ProfileError(
  //       error: ('No Internet'),
  //     );
  //   } on HttpException {
  //     yield const ProfileError(
  //       error: ('No Service'),
  //     );
  //   } on FormatException {
  //     yield const ProfileError(
  //       error: ('No Format Exception'),
  //     );
  //   } catch (e) {
  //     yield ProfileError(error: ('Check username'));
  //   }
  // }
}
