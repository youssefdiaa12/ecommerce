part of 'search_view_model_cubit.dart';

@immutable
abstract class SearchViewModelState {}

class SearchViewModelInitial extends SearchViewModelState {}
class SearchViewModelLoading extends SearchViewModelState {}
class SearchViewModelSuccess extends SearchViewModelState {
  List<Product> products;
  SearchViewModelSuccess(this.products);
}
class SearchViewModelError extends SearchViewModelState {}
class SearchViewModelEmpty extends SearchViewModelState {}
class AuthenticatedTapState extends SearchViewModelState {}
class UnAuthenticatedTapState extends SearchViewModelState {}
