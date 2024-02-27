import 'package:ecommerce/data/dataSource/CartListDataSource.dart';
import 'package:injectable/injectable.dart';
import '../../domain/repository/cartListRepository1.dart';
import '../model/productCartListResponse1/ProductCartListResponse1.dart';
@Injectable(as: cartListRepository1)
class CartlistRepositoryImp extends cartListRepository1 {
  CartListDataSource CartListDataSource1;
 @factoryMethod CartlistRepositoryImp(this.CartListDataSource1);

  @override
  Future<String?> UpdateProductToCartList(String productId, String token,int count)async {
    var response = await CartListDataSource1.UpdateProductToCartList(productId, token,count);
    return response;
  }

  @override
  Future<String?> addProductToCartList(String productId, String token) async{
    var response = await CartListDataSource1.addProductToCartList(productId, token);
    return response;
  }

  @override
  Future<ProductCartListResponse1?> getProductsCartList(String token) async{
    var response = await CartListDataSource1.getProductsCartList(token);
    return response;
  }

  @override
  Future<String?> removeProductToCartList(String productId, String token)async {
    var response = await CartListDataSource1.removeProductToCartList(productId, token);
    return response;

  }


}