import 'package:ecommerce/domain/repository/authenticationRepository.dart';
import 'package:injectable/injectable.dart';
import '../../data/model/User/User.dart';
@injectable
class loginUseCase{

  authenticationRepository AuthenticationRepository;
  @factoryMethod loginUseCase(this.AuthenticationRepository);

  Future<User_api?> invoke( String email, String password)async{
    return await AuthenticationRepository.Login(email, password);
  }
}
