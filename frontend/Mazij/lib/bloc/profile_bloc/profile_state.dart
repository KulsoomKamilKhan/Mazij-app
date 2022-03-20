part of 'profile_bloc.dart';

@immutable
abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileError extends ProfileState {
  final error;
  const ProfileError({this.error});
}

class ProfileUpdated extends ProfileState {}
