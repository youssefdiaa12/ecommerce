part of 'home_tap_view_model_cubit.dart';

sealed class HomeTapViewModelState {}

class HomeTapViewModelInitial extends HomeTapViewModelState {}
class HomeTapViewModelLoading extends HomeTapViewModelState {}
class HomeTapViewModelSuccessful extends HomeTapViewModelState {
  List<Category> categories;
  List<Brand> brands;
  List<Product> products;
  @factoryMethod HomeTapViewModelSuccessful(this.categories, this.brands, this.products);
} //
class HomeTapViewModelError extends HomeTapViewModelState {
  String error;
  HomeTapViewModelError(this.error);
}
class unAuthorized extends HomeTapViewModelState {}
