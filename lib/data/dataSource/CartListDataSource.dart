import '../../domain/model/Product.dart';

abstract class CartListDataSource {
  Future<String?> addProductToCartList(String productId,String token);
  Future<String?> removeProductToCartList(String productId,String token);
  Future<List<Product>?> getProductList(String token);
}