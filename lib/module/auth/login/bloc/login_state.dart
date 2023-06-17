// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginLoaded extends LoginState {
  final LoginResponseModel model;
  const LoginLoaded({
    required this.model,
  });
}

class LoginError extends LoginState {
  final String message;
  const LoginError({
    required this.message,
  });
}
