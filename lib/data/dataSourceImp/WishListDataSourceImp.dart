import 'package:ecommerce/data/model/productResponse/ProductDto.dart';
import 'package:injectable/injectable.dart';

import '../../domain/model/Product.dart';
import '../api_Manager.dart';
import '../dataSource/WishListDataSource.dart';
@Injectable(as: WishListDataSource)
class WishListDataSourceImp extends WishListDataSource {

  Api_Manager api_manager;
  @factoryMethod WishListDataSourceImp(this.api_manager);
  @override
  Future<String?> addProductToWishList(String productId,String token) async {
    var response= await api_manager.addProductToWishList(productId,token);
    return response;
  }
  Future<String?> removeProductToWishList(String productId,String token) async {
    var response= await api_manager.removeProductToWishList(productId,token);
    return response;
  }
  Future<List<Product>?> getProductWishList(String token) async {
    List<ProductDto>? response= await api_manager.getProductList(token);
    return response?.map((productDto) => productDto.toProduct()).toList();
  }

  }
