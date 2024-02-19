part of 'cart_list_view_model_cubit.dart';

@immutable
abstract class CartListViewModelState {}

class CartListViewModelInitial extends CartListViewModelState {}
class CartListViewModelLoading extends CartListViewModelState {}
class CartListViewModelSuccess extends CartListViewModelState {}
class CartListViewModelFailure extends CartListViewModelState {
  final String error;
  CartListViewModelFailure(this.error);
}
class unAuthorized extends CartListViewModelState {}
