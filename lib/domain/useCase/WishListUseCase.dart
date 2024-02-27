import 'package:ecommerce/domain/repository/WishListRepository1.dart';
import 'package:injectable/injectable.dart';
import '../model/Product.dart';
@injectable
class WishListdUseCase{
  WishListRepository1 addProductToCartListRepository1;
  @factoryMethod WishListdUseCase(this.addProductToCartListRepository1);

  Future<String?> invoke_wish(String productId,String token)async{
    var response=  await addProductToCartListRepository1.addProductToWishList(productId, token);
    return response;
  }
  Future<String?> invoke_removeFromwish(String productId,String token)async{
    var response=  await addProductToCartListRepository1.removeProductFromWishList(productId, token);
    return response;
  }
  Future<List<Product>?> invoke_getProductWishList(String token)async{
    List<Product>? response= await addProductToCartListRepository1.getProductList(token);
    return response;
  }
}
