import 'package:ecommerce/data/dataSource/productsDataSource.dart';
import 'package:ecommerce/domain/model/Product.dart';
import 'package:injectable/injectable.dart';

import '../../domain/repository/productRepository.dart';
@Injectable(as: productRepository)
class productRepositoryImp extends productRepository {


  ProductsDataSource OnlineProductsDataSource;
  @factoryMethod productRepositoryImp(this.OnlineProductsDataSource);
  @override
  Future<List<Product>> getProducts(int pageNo, int limit, {ProductSortBy? sortBy,String? categoryid}) async {
    var obj= await OnlineProductsDataSource.getProducts(
         pageNo,limit,
        productSortBy: sortBy,
        categoryid: categoryid??"");
    print("repos");
    return obj;

  }
  Future<num?>getSpecificProduct(String productId) async {
   num? price= await OnlineProductsDataSource.getSpecificProduct(productId);
   print("repo1");
   print(price);
   return price;
  }
}