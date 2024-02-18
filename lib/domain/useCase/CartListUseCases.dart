import 'package:injectable/injectable.dart';
import '../model/Product.dart';
import '../repository/CartListRepository.dart';
@injectable
class CartListdUseCase{
  addProductToCartListRepository addProductToCartListRepository1;
  @factoryMethod CartListdUseCase(this.addProductToCartListRepository1);

  Future<String?> invoke_addToCart(String productId,String token)async{
  var response=  await addProductToCartListRepository1.addProductToCartList(productId, token);
  return response;
  }
  Future<String?> invoke_removeFromCart(String productId,String token)async{
    var response=  await addProductToCartListRepository1.removeProductToCartList(productId, token);
    return response;
  }
Future<List<Product>?> invoke_getProductList(String token)async{
  List<Product>? response= await addProductToCartListRepository1.getProductList(token);
  return response;
}
}
