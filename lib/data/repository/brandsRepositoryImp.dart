import 'package:ecommerce/domain/model/Brand.dart';
import 'package:injectable/injectable.dart';
import '../../domain/repository/brandRepository.dart';
import '../dataSource/brandDataSource.dart';

@Injectable(as: brandRepository)
class brandRepositoryImp extends brandRepository {
  brandDataSource OnlineBrandsDataSource;

  @factoryMethod
  brandRepositoryImp(this.OnlineBrandsDataSource);

  @override
  Future<List<Brand>> getBrand() async {
    var obj = await OnlineBrandsDataSource.getBrands();
    return obj;
  }
}
