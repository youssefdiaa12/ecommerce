import 'package:ecommerce/domain/model/Product.dart';
import 'package:ecommerce/domain/repository/productRepository.dart';

import '../../domain/model/Category.dart';

abstract class ProductsDataSource {
  Future<List<Product>> getProducts(
      int pageNo, int limit,
      {ProductSortBy? productSortBy, String? categoryid});
}