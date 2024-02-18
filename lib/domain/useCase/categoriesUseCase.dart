import 'package:ecommerce/domain/repository/categoriesRepository.dart';
import 'package:injectable/injectable.dart';

import '../model/Category.dart';
@injectable
class categoriesUseCase{

  CategoriesRepository categoriesRepository;
 @factoryMethod categoriesUseCase(this.categoriesRepository);

  Future<List<Category>> invoke()async{
    var obj= await categoriesRepository.getCategories();
  return obj;
  }
}