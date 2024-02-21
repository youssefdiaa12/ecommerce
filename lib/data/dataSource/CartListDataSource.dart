import '../model/productCartListResponse1/ProductCartListResponse1.dart';

abstract class CartListDataSource {
  Future<String?> addProductToCartList(String productId,String token);
  Future<String?> removeProductToCartList(String productId,String token);
  Future<ProductCartListResponse1?> getProductsCartList(String token);
  Future<String?>UpdateProductToCartList(String productId, String token,int count);

}