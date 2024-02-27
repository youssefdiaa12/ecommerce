import 'package:injectable/injectable.dart';
import '../../domain/model/Product.dart';
import '../../domain/repository/WishListRepository1.dart';
import '../dataSource/WishListDataSource.dart';
@Injectable(as: WishListRepository1)
class WishListRepositoryImp1 extends WishListRepository1 {
  WishListDataSource addProductToCartListDataSource1;
  @factoryMethod WishListRepositoryImp1(this.addProductToCartListDataSource1);
  @override
  Future<String?> addProductToWishList(String productId, String token) async {
    var response = await addProductToCartListDataSource1.addProductToWishList(productId, token);
    return response;
  }
  Future<String?> removeProductFromWishList(String productId,String token) async {
    var response= await addProductToCartListDataSource1.removeProductToWishList(productId,token);
    return response;
  }
  Future<List<Product>?> getProductList(String token) async {
    List<Product>? response= await addProductToCartListDataSource1.getProductWishList(token);
    return response;
  }
}