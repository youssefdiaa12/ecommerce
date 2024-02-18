import 'package:ecommerce/domain/repository/authenticationRepository.dart';
import 'package:injectable/injectable.dart';

import '../../data/model/User/User.dart';
@injectable
class resetPasswordUseCase{
  authenticationRepository AuthenticationRepository;
  @factoryMethod resetPasswordUseCase(this.AuthenticationRepository);

  Future<String?> invoke(String email,String password)async{
    String? result= await AuthenticationRepository.ResetPassword(email, password);
    print(result);
    print("useCase");
    return result;
  }
}
