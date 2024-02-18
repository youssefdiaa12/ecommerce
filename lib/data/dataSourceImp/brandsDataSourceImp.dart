import 'package:ecommerce/domain/model/Brand.dart';
import 'package:injectable/injectable.dart';
import '../api_Manager.dart';
import '../dataSource/brandDataSource.dart';
@Injectable(as: brandDataSource)
class brandDataSourceImp extends brandDataSource {
  Api_Manager api_manager;

  @factoryMethod brandDataSourceImp(this.api_manager);

  @override
  Future<List<Brand>> getBrands() async {
    var response= await api_manager.getBrands();
    return response.data!.map((brandDto) => brandDto.toBrand()).toList();
  }
}