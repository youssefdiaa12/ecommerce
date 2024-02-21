part of 'update_user_data_cubit.dart';

@immutable
abstract class UpdateUserDataState {}

class UpdateUserDataInitial extends UpdateUserDataState {
  UpdateUserDataInitial();

}
class UpdateUserDataLoading extends UpdateUserDataState {}
class UpdateUserDataSuccess extends UpdateUserDataState {}
class UpdateUserDataError extends UpdateUserDataState {
  String? error;
  UpdateUserDataError(this.error);
}
class update1 extends UpdateUserDataState {}
