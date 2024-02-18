import 'package:bloc/bloc.dart';
import 'package:ecommerce/di/di.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

import '../../domain/model/Product.dart';
import '../../domain/useCase/CartListUseCases.dart';
import '../ProivderViewModel/app_provider.dart';

part 'loved_tap_state.dart';

@injectable
class LovedTapCubit extends Cubit<LovedTapState> {
  CartListdUseCase CartListdUseCases1;

  @factoryMethod
  LovedTapCubit(this.CartListdUseCases1) : super(InitialLovedTapState());

  Future<bool> checkUser() async {
    var provider1 = getIt<AppProvider>();
    bool is_logged = await provider1.loggedin();
    if (is_logged) {
      emit(AuthenticatedTapState());
      return true;
    } else {
      emit(UnAuthenticatedTapState());
      return false;
    }
  }

  Future<void> getLovedProductList(String token) async {
    bool isLoggedin = await checkUser();
    if (isLoggedin) {
      print("logged in");
      emit(LoadingLovedTapState());
      try {
        List<Product>? products = await CartListdUseCases1.invoke_getProductList(token);
        emit(SuccessLovedTapState(
          products: products ?? [],
        ));
      } catch (e) {
        emit(ErrorLovedTapState());
      }
    }

  }
}
