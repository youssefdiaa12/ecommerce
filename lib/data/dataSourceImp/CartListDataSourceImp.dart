import 'package:ecommerce/data/model/productResponse/ProductDto.dart';
import 'package:injectable/injectable.dart';

import '../../domain/model/Product.dart';
import '../api_Manager.dart';
import '../dataSource/CartListDataSource.dart';
@Injectable(as: CartListDataSource)
class addProductToCartListDataSourceImp extends CartListDataSource {

  Api_Manager api_manager;
  @factoryMethod addProductToCartListDataSourceImp(this.api_manager);
  @override
  Future<String?> addProductToCartList(String productId,String token) async {
    var response= await api_manager.addProductToCartList(productId,token);
    return response;
  }
  Future<String?> removeProductToCartList(String productId,String token) async {
    var response= await api_manager.removeProductToCartList(productId,token);
    return response;
  }
  Future<List<Product>?> getProductList(String token) async {
    List<ProductDto>? response= await api_manager.getProductList(token);
    return response?.map((productDto) => productDto.toProduct()).toList();
  }
  }
