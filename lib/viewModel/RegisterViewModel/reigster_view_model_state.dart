part of 'reigster_view_model_cubit.dart';

@immutable
abstract class ReigsterViewModelState {}

class ReigsterViewModelInitial extends ReigsterViewModelState {}
class ReigsterViewModelLoading extends ReigsterViewModelState {}
class ReigsterViewModelSuccess extends ReigsterViewModelState {
  User user;
  ReigsterViewModelSuccess(this.user);

}
class ReigsterViewModelError extends ReigsterViewModelState {
  String error;
  ReigsterViewModelError(this.error);
}
