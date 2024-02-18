import 'package:ecommerce/domain/model/Product.dart';
import 'package:ecommerce/domain/repository/categoriesRepository.dart';
import 'package:ecommerce/domain/repository/productRepository.dart';
import 'package:injectable/injectable.dart';

import '../model/Category.dart';
@injectable
class MostSellingProductsUseCase{

  productRepository ProductRepository;
  @factoryMethod MostSellingProductsUseCase(this.ProductRepository);

  Future<List<Product>> invoke(int pageNo,int Limit)async{
    var obj= await ProductRepository.getProducts(pageNo,Limit,
        sortBy: ProductSortBy.MostSelling);
    return obj;
  }
}