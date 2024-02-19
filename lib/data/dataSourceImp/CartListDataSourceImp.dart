import 'package:ecommerce/data/api_Manager.dart';
import 'package:injectable/injectable.dart';
import '../dataSource/CartListDataSource.dart';
import '../model/ProductCartListResponse/ProductCartListResponse.dart';
@Injectable(as: CartListDataSource)
 class CartListDataSourceImp extends CartListDataSource {
  Api_Manager api_manager;
  @factoryMethod CartListDataSourceImp(this.api_manager);
  Future<String?> addProductToCartList(String productId,String token)async{
    print("amora");
    return await api_manager.addProductToCartList(productId, token);
  }
  Future<String?> removeProductToCartList(String productId,String token)async{
    return await api_manager.removeFromCartList(productId, token);
  }
  Future<ProductCartListResponse?> getProductsCartList(String token)async{
    return await api_manager.getCartListResponse(token);
  }
  Future<String?>UpdateProductToCartList(String productId, String token,int count) async {
    return await api_manager.UpdateProductToCartList(productId, token, count);
  }

}