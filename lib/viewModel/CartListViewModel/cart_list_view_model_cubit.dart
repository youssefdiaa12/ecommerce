import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

import '../../di/di.dart';
import '../../domain/useCase/CartListUseCase.dart';
import '../ProivderViewModel/app_provider.dart';

part 'cart_list_view_model_state.dart';

@injectable
class CartListViewModelCubit extends Cubit<CartListViewModelState> {
  CartListdUseCase cartListdUseCase;

  @factoryMethod
  CartListViewModelCubit(this.cartListdUseCase)
      : super(CartListViewModelInitial());

  Future<void> invoke_getProductCartList(String token) async {
    emit(CartListViewModelLoading());
  }

  Future<void> invoke_addToCart(
      String productId, String token, int count) async {
    emit(CartListViewModelLoading());
    try {
      var response =  await cartListdUseCase.invoke_addToCart(productId, token, count);
      if (response == "Product added successfully to your cart") {
        emit(CartListViewModelSuccess());
      } else {
        emit(CartListViewModelFailure("Failed to add to cart"));
      }
    } catch (e) {
      emit(CartListViewModelFailure(e.toString()));
    }
  }
  Future<bool> checkAuthority()async{
    var provider1 = getIt<AppProvider>();
    bool is_logged =await provider1.loggedin();
    if(!is_logged){
      emit(unAuthorized());
      return false;
    }
    else{
      return true;
    }
  }

}
