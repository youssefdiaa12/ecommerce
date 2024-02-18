import 'package:ecommerce/domain/model/Product.dart';

import '../model/Category.dart';

abstract class productRepository {
  Future<List<Product>> getProducts(
      int pageNo, int limit,
      {ProductSortBy? sortBy, String? categoryid});

}


enum  ProductSortBy{
HighestPrice("price"),
LowestPrice ("price"),
MostSelling("-sold");
  final String sort;
 const ProductSortBy(this.sort);
}