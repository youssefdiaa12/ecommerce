import 'package:injectable/injectable.dart';

import '../../domain/model/Category.dart';
import '../api_Manager.dart';
import '../dataSource/categoriesDataSource.dart';
@Injectable(as: CategoriesDataSource)
class categoriesDataSourceImp extends CategoriesDataSource {
  Api_Manager api_manager;

 @factoryMethod categoriesDataSourceImp(this.api_manager);

  @override
  Future<List<Category>> getCategories() async {
    var response= await api_manager.getCategories();
    return response.data!.map((categoryDto) => categoryDto.toCategory()).toList();

  }
}