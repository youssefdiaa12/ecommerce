import 'package:injectable/injectable.dart';

import '../../domain/model/Product.dart';
import '../../domain/repository/CartListRepository.dart';
import '../dataSource/CartListDataSource.dart';
@Injectable(as: addProductToCartListRepository)
class addToCartListRepositoryImp extends addProductToCartListRepository {
  CartListDataSource addProductToCartListDataSource1;
  @factoryMethod addToCartListRepositoryImp(this.addProductToCartListDataSource1);
  @override
  Future<String?> addProductToCartList(String productId, String token) async {
    var response = await addProductToCartListDataSource1.addProductToCartList(productId, token);
    return response;
  }
  Future<String?> removeProductToCartList(String productId,String token) async {
    var response= await addProductToCartListDataSource1.removeProductToCartList(productId,token);
    return response;
  }
  Future<List<Product>?> getProductList(String token) async {
    List<Product>? response= await addProductToCartListDataSource1.getProductList(token);
    return response;
  }
}