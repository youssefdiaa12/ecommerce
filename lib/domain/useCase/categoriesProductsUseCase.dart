import 'package:ecommerce/domain/model/Category.dart';
import 'package:ecommerce/domain/model/Product.dart';
import 'package:ecommerce/domain/repository/productRepository.dart';
import 'package:injectable/injectable.dart';
@injectable
class categoriesProductsUseCase{

  productRepository ProductRepository;
  @factoryMethod categoriesProductsUseCase(this.ProductRepository);

  Future<List<Product>> invoke(int pageNo,int Limit,{Category? category})async{
    var obj= await ProductRepository.getProducts(pageNo,Limit,categoryid: category?.id);
    print("useCase");
print(obj.length);
    return obj;
  }
  Future<num?>getSpecificProduct(String productId) async {

   num? price= await ProductRepository.getSpecificProduct(productId);
   print("repo");
   print(price);
   return price;
  }
}