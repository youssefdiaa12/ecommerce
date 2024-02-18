import 'package:injectable/injectable.dart';

import '../../domain/model/Category.dart';
import '../../domain/repository/categoriesRepository.dart';
import '../dataSource/categoriesDataSource.dart';
@Injectable(as: CategoriesRepository)
class categoriesRepositoryImp extends CategoriesRepository {


  CategoriesDataSource OnlineCategoriesDataSource;
 @factoryMethod categoriesRepositoryImp(this.OnlineCategoriesDataSource);
  @override
  Future<List<Category>> getCategories() async{
    var obj= await OnlineCategoriesDataSource.getCategories();
    return obj;

  }
}