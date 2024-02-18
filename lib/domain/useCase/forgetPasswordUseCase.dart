import 'package:ecommerce/domain/repository/authenticationRepository.dart';
import 'package:injectable/injectable.dart';

import '../../data/model/User/User.dart';
@injectable
class forgetPasswordUseCase{
  authenticationRepository AuthenticationRepository;
  @factoryMethod forgetPasswordUseCase(this.AuthenticationRepository);

  Future<String?> invoke(String email)async{
    return await AuthenticationRepository.ForgetPassword(email);
  }
}
