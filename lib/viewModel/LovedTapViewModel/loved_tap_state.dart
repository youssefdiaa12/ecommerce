part of 'loved_tap_cubit.dart';

@immutable
abstract class LovedTapState {}
class InitialLovedTapState extends LovedTapState {}
class UnAuthenticatedTapState extends LovedTapState {}
class AuthenticatedTapState extends LovedTapState {}
class ErrorLovedTapState extends LovedTapState {}
class LoadingLovedTapState extends LovedTapState {}
class SuccessLovedTapState extends LovedTapState {
  List<Product> products;
  SuccessLovedTapState({required this.products});

}


