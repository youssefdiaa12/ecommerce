import 'package:ecommerce/domain/model/Brand.dart';
import 'package:ecommerce/domain/repository/brandRepository.dart';
import 'package:injectable/injectable.dart';

import '../model/Category.dart';
@injectable
class brandsUseCase{

  brandRepository BrandsRepository;
  @factoryMethod brandsUseCase(this.BrandsRepository);

  Future<List<Brand>> invoke()async{
    var obj= await BrandsRepository.getBrand();
    return obj;
  }
}