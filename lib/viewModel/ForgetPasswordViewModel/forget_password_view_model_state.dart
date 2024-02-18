part of 'forget_password_view_model_cubit.dart';

@immutable
abstract class ForgetPasswordViewModelState {}

class ForgetPasswordViewModelInitial extends ForgetPasswordViewModelState {}
class ForgetPasswordViewModelLoading extends ForgetPasswordViewModelState {}
class ForgetPasswordViewModelSuccess extends ForgetPasswordViewModelState {
  String? msg;
  ForgetPasswordViewModelSuccess(this.msg);

}
class ForgetPasswordViewModelError extends ForgetPasswordViewModelState
{
  String? msg;
  ForgetPasswordViewModelError(this.msg);
}
