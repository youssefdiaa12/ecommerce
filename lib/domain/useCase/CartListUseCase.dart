import 'package:injectable/injectable.dart';
import '../../data/model/productCartListResponse1/ProductCartListResponse1.dart';
import '../repository/cartListRepository1.dart';
@injectable
class CartListdUseCase{
  cartListRepository1 cartlistRepositoryImp;
  @factoryMethod CartListdUseCase(this.cartlistRepositoryImp);

  Future<String?> invoke_addToCart(String productId,String token,int count)async{
    print("dddd");
    var response=  await cartlistRepositoryImp.addProductToCartList(productId, token);
    print("dddd1");
    print(response);
    if(count>1&&response=="Product added successfully to your cart"){
      print("raaa");
      response= await cartlistRepositoryImp.UpdateProductToCartList(productId, token,count);
      print("rororo");
      print(response);
      if(response=="success"){
        print("dededede");
        return "Product added successfully to your cart";
      }
    }

    return response;
  }
  Future<String?> invoke_removeFromCart(String productId,String token)async{
    var response=  await cartlistRepositoryImp.removeProductToCartList(productId, token);
    return response;
  }
  Future<ProductCartListResponse1?> invoke_getProductCartList(String token)async{
   var response= await cartlistRepositoryImp.getProductsCartList(token);
   print("a70");
   print(response);
    return response;
  }
  Future<String?> invoke_UpdateProductToCartList(String productId, String token,int count)async{
    var response = await cartlistRepositoryImp.UpdateProductToCartList(productId, token,count);
    return response;
  }
}
