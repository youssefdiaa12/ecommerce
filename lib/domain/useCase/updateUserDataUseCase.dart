import 'package:injectable/injectable.dart';
import '../repository/updateUserDataRepository.dart';
@injectable
class updateUserDataUseCase{

  updateUserDataRepository updateUserDataRepository1;
  @factoryMethod updateUserDataUseCase(this.updateUserDataRepository1);

  Future<String?> invoke_update_user_data(String name, String email, String phone, String token)async{
    return await updateUserDataRepository1.updateUser(name, email, phone, token);
  }
  Future<String?> invoke_update_user_password(String currentPass,String password, String token)async{
    return await updateUserDataRepository1.updateUserPass(currentPass, password, token);
  }
}
