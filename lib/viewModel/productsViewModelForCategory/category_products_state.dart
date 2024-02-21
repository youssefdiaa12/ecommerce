part of 'category_products_cubit.dart';

@immutable
abstract class CategoryProductsState {}

class CategoryProductsInitial extends CategoryProductsState {}
class CategoryProductsLoading extends CategoryProductsState {}
class CategoryProductsSuccessful extends CategoryProductsState {
  final List<Product> products;
  CategoryProductsSuccessful(this.products);
}
class CategoryProductsError extends CategoryProductsState {
  final String message;
  CategoryProductsError(this.message);
}
class unAuthorized1 extends CategoryProductsState {}
