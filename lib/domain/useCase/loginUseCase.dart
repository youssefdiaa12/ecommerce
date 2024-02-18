import 'package:ecommerce/domain/model/Product.dart';
import 'package:ecommerce/domain/repository/authenticationRepository.dart';
import 'package:ecommerce/domain/repository/categoriesRepository.dart';
import 'package:ecommerce/domain/repository/productRepository.dart';
import 'package:injectable/injectable.dart';

import '../../data/model/User/User.dart';
import '../model/Category.dart';
@injectable
class loginUseCase{

  authenticationRepository AuthenticationRepository;
  @factoryMethod loginUseCase(this.AuthenticationRepository);

  Future<User?> invoke( String email, String password)async{
    return await AuthenticationRepository.Login(email, password);
  }
}
