import 'package:injectable/injectable.dart';

import '../../domain/model/Product.dart';
import '../../domain/repository/wishListRepository.dart';
import '../dataSource/WishListDataSource.dart';
@Injectable(as: WishListRepository)
class addToCartListRepositoryImp extends WishListRepository {
  WishListDataSource addProductToCartListDataSource1;
  @factoryMethod addToCartListRepositoryImp(this.addProductToCartListDataSource1);
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