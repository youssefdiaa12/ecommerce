import 'package:ecommerce/domain/model/Product.dart';
import 'package:injectable/injectable.dart';

import '../../domain/model/Category.dart';
import '../../domain/repository/productRepository.dart';
import '../api_Manager.dart';
import '../dataSource/productsDataSource.dart';
@Injectable(as: ProductsDataSource)
class productsDataSourceImp extends ProductsDataSource {
  Api_Manager api_manager;

  @factoryMethod productsDataSourceImp(this.api_manager);

  @override
  Future<List<Product>> getProducts(
      int pageNo, int limit,
      {ProductSortBy? productSortBy,String?categoryid}) async {
    var response= await api_manager.getProducts(
        pageNo,limit,
        productSortBy: productSortBy
        ,categoryid: categoryid??"");
    print("hi");
    return response.data!.map((productDto) => productDto.toProduct()).toList();
  }

}