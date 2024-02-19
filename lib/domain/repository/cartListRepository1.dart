import '../../data/model/ProductCartListResponse/ProductCartListResponse.dart';

abstract class cartListRepository1 {
  Future<String?> addProductToCartList(String productId,String token);
  Future<String?> removeProductToCartList(String productId,String token);
  Future<ProductCartListResponse?> getProductsCartList(String token);
  Future<String?>UpdateProductToCartList(String productId, String token,int count);
}