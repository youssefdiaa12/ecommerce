part of 'reset_password_code_view_model_cubit.dart';

@immutable
abstract class ResetPasswordCodeViewModelState {}

class ResetPasswordViewModelInitial extends ResetPasswordCodeViewModelState {}
class ResetPasswordViewModelLoading extends ResetPasswordCodeViewModelState {}
class ResetPasswordViewModelSuccessful extends ResetPasswordCodeViewModelState {}
class ResetPasswordViewModelError extends ResetPasswordCodeViewModelState {
  final String message;
  ResetPasswordViewModelError(this.message);
}
