import '../../domain/model/Product.dart';

abstract class WishListDataSource {
  Future<String?> addProductToWishList(String productId,String token);
  Future<String?> removeProductToWishList(String productId,String token);
  Future<List<Product>?> getProductWishList(String token);

}