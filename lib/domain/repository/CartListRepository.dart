import '../model/Product.dart';

abstract class addProductToCartListRepository{
  Future<String?> addProductToCartList(String productId,String token);
  Future<String?> removeProductToCartList(String productId,String token);
  Future<List<Product>?> getProductList(String token);
}