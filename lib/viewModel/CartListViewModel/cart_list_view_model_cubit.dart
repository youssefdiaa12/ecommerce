import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import '../../data/Services/disk_storage.dart';
import '../../data/model/User/UserCartList.dart';
import '../../data/model/User/user_cart_list_dao.dart';
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
          num price= appProvider.products_cartList![i].price??0;
          num count=await disk_storge().get_cart_product(appProvider.products_cartList![i].product!.id??"");
          appProvider.product_cartList_count![appProvider.products_cartList![i].product!.id??""]=count.toInt();
          print("the counter is");
          print(count);
          print("the price is");
          print(price);
          prices.add(price*count);
          total+=(price*count);
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
        print(productId);
        List<num?>prices=[];
        int val=appProvider.product_cartList_count![productId]??0;
        val=val+count;
        UserCartList obj=UserCartList(productId,val);
       bool is_found=await CartListDao.is_found_task(obj,AppProvider.user_fire_base?.id??"");
       if(is_found){
         await CartListDao.editTask(obj,AppProvider.user_fire_base?.id??"");
       }
       else{
         await CartListDao.createTask(obj,AppProvider.user_fire_base?.id??"");
       }
        appProvider.update_counter_product(productId,val);
        await appProvider.getCartList(AppProvider.user?.token??"");
        num total=0;
        for (var i = 0; i < appProvider.product_cartList_count!.length; i++) {
          num? price=appProvider.products_cartList![i].price??0;
          prices.add(price);
          total+=price*appProvider.product_cartList_count![appProvider.products_cartList![i].product!.id]!;
        }
        emit(CartListViewModelSuccess(
          appProvider.products_cartList ?? [],
          prices,
          total
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
        UserCartList taskia=UserCartList(productId,0);
        CartListDao.deleteTask(taskia,AppProvider.user_fire_base?.id??"");
        print(appProvider.product_cartList_count!.length);
        for (var i = 0; i < appProvider.product_cartList_count!.length; i++) {
          num? price=appProvider.products_cartList![i].price??0;
          prices.add(price);
          total+=price*appProvider.product_cartList_count![appProvider.products_cartList![i].product!.id]!;
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
