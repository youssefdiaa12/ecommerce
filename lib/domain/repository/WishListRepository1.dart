import '../model/Product.dart';

abstract class WishListRepository1{
  Future<String?> addProductToWishList(String productId,String token);
  Future<String?> removeProductFromWishList(String productId,String token);
  Future<List<Product>?> getProductList(String token);
}