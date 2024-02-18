part of 'categories_view_model_cubit.dart';

@immutable
abstract class CategoriesViewModelState {}

class CategoriesViewModelInitial extends CategoriesViewModelState {}
class CategoriesViewModelLoading extends CategoriesViewModelState {}
class CategoriesViewModelSuccessful extends CategoriesViewModelState {
  List<Category> categories;
  CategoriesViewModelSuccessful(this.categories);
}
class CategoriesViewModelError extends CategoriesViewModelState {
  String error;
  CategoriesViewModelError(this.error);
}
