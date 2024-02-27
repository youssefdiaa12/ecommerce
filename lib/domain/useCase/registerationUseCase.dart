import 'package:ecommerce/domain/repository/authenticationRepository.dart';
import 'package:injectable/injectable.dart';
import '../../data/model/User/User.dart';
@injectable
class registerationUseCase{

  authenticationRepository AuthenticationRepository;
  @factoryMethod registerationUseCase(this.AuthenticationRepository);

 Future<User_api?> invoke(String name, String email, String password, String rePassword,String phoneNumber)async{
   return await AuthenticationRepository.Register(name, email, password, rePassword, phoneNumber);
 }
}
