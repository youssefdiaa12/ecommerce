import 'package:ecommerce/domain/repository/authenticationRepository.dart';
import 'package:injectable/injectable.dart';

@injectable
class resetPasswordUseCase{
  authenticationRepository AuthenticationRepository;
  @factoryMethod resetPasswordUseCase(this.AuthenticationRepository);

  Future<String?> invoke(String email,String password)async{
    String? result= await AuthenticationRepository.ResetPassword(email, password);
    return result;
  }
}
