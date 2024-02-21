part of 'cart_list_view_model_cubit.dart';

@immutable
abstract class CartListViewModelState {}

class CartListViewModelInitial extends CartListViewModelState {}
class CartListViewModelLoading extends CartListViewModelState {}
class CartListViewModelSuccess extends CartListViewModelState {
  List<Products> products;
  List<num?>prices;
  num total;

  CartListViewModelSuccess(this.products,this.prices,this.total);

}
class CartListViewModelFailure extends CartListViewModelState {
  final String error;
  CartListViewModelFailure(this.error);
}
class unAuthorized extends CartListViewModelState {}
