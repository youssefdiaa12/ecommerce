import 'package:ecommerce/domain/repository/authenticationRepository.dart';
import 'package:injectable/injectable.dart';

@injectable
class resetPasswordCodeUseCase{
  authenticationRepository AuthenticationRepository;
  @factoryMethod resetPasswordCodeUseCase(this.AuthenticationRepository);

  Future<String?> invoke(String code)async{
    String? result= await AuthenticationRepository.ResetPasswordCode(code);
    return result;
  }
}
