part of 'reset_password_cubit.dart';

@immutable
abstract class ResetPasswordState {}

class ResetPasswordInitial extends ResetPasswordState {}
class ResetPasswordLoading extends ResetPasswordState {}
class ResetPasswordSuccess extends ResetPasswordState {
  String? result;
  ResetPasswordSuccess(this.result);

}
class ResetPasswordError extends ResetPasswordState {}
