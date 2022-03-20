part of 'profile_bloc.dart';

@immutable
abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class UpdateProfile extends ProfileEvent {
  final String bio;
  final String profile_pic;
  const UpdateProfile({required this.bio, required this.profile_pic});
}
