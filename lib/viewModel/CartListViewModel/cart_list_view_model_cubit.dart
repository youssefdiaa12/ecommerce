import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import '../../data/model/productCartListResponse1/ProductCartListResponse1.dart';
import '../../data/model/productCartListResponse1/Products.dart';
import '../../di/di.dart';
import '../../domain/useCase/CartListUseCase.dart';
import '../../domain/useCase/categoriesProductsUseCase.dart';
import '../ProivderViewModel/app_provider.dart';

part 'cart_list_view_model_state.dart';

@injectable
class CartListViewModelCubit extends Cubit<CartListViewModelState> {
  CartListdUseCase cartListdUseCase;
  categoriesProductsUseCase categoriesProductsUseCase1;
  @factoryMethod
  CartListViewModelCubit(this.cartListdUseCase, this.categoriesProductsUseCase1)
      : super(CartListViewModelInitial());

  Future<void> invoke_getProductCartList(String token) async {
    if(await checkAuthority()==false){
      return;
    }

    emit(CartListViewModelLoading());
    try{
      ProductCartListResponse1? response=await cartListdUseCase.invoke_getProductCartList(token);
      if(response!=null){
        List<num?>prices=[];
        num total=0;
        AppProvider appProvider = getIt<AppProvider>();
        for (var i = 0; i < appProvider.products_cartList!.length; i++) {
          num? price=await categoriesProductsUseCase1.getSpecificProduct(appProvider.products_cartList![i].product!.id??"");
          prices.add(price??0);
          total+=price??0;
        }
        emit(CartListViewModelSuccess( response.data?.products??[],prices,total));
      }
    }
    catch(e){
      emit(CartListViewModelFailure(e.toString()));
    }
  }

  Future<void> invoke_addToCart(
      String productId, String token, int count) async {
    emit(CartListViewModelLoading());
    try {
      var response =  await cartListdUseCase.invoke_addToCart(productId, token, count);
      if (response == "Product added successfully to your cart") {
        print("Product added successfully to your cart");
        print("app");
        AppProvider appProvider = getIt<AppProvider>();
        appProvider.product_cartList_count![productId] = count;
        await appProvider.getCartList(AppProvider.user?.token??"");

        emit(CartListViewModelSuccess(
          appProvider.products_cartList ?? [],
          [],0
        ));
      }
      else {
        emit(CartListViewModelFailure("Failed to add to cart"));
      }
    } catch (e) {
      emit(CartListViewModelFailure(e.toString()));
    }
  }

  Future<void> invoke_removeFromCart(String productId, String token) async {
    emit(CartListViewModelLoading());
    try {
      var response =  await cartListdUseCase.invoke_removeFromCart(productId, token);
      if (response == "success") {
        print("fih");
        List<num?>prices=[];
        num total=0;
        AppProvider appProvider = getIt<AppProvider>();
        appProvider.product_cartList_count!.remove(productId);
        appProvider.products_cartList!.removeWhere((element) => element.product!.id == productId);
        print("sz");
        print(appProvider.product_cartList_count!.length);
        for (var i = 0; i < appProvider.product_cartList_count!.length; i++) {
          num? price=await categoriesProductsUseCase1.getSpecificProduct(appProvider.products_cartList![i].product!.id??"");
          prices.add(price??0);
          total+=price!*appProvider.product_cartList_count![appProvider.products_cartList![i].product!.id]!;
        }
        await appProvider.getCartList(AppProvider.user?.token??"");
        emit(CartListViewModelSuccess(
          appProvider.products_cartList ?? [],
            prices,
            total
        ));
      }
      else {
        emit(CartListViewModelFailure("Failed to remove from cart"));
      }
    }
    catch (e) {
      print(e);
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
