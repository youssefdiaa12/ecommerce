import 'package:ecommerce/domain/model/Product.dart';
import 'package:ecommerce/domain/repository/productRepository.dart';
import 'package:injectable/injectable.dart';

@injectable
class getAllProductsUseCase{

  productRepository ProductRepository;
  @factoryMethod getAllProductsUseCase(this.ProductRepository);

  Future<List<Product>> invoke(int pageNo,int Limit)async{
    var obj= await ProductRepository.getProducts(pageNo,Limit);
    return obj;
  }
}