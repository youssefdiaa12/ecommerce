part of 'login_view_model_cubit.dart';

@immutable
abstract class LoginViewModelState {}

class LoginViewModelInitial extends LoginViewModelState {}
class LoginViewModelLoading extends LoginViewModelState {}
class LoginViewModelSuccess extends LoginViewModelState {
  User_api? user;
  LoginViewModelSuccess(this.user);
}
class LoginViewModelError extends LoginViewModelState {
  String error;
  LoginViewModelError(this.error);
}
