import 'package:injectable/injectable.dart';
import '../api_Manager.dart';
import '../dataSource/authenticationDataSource.dart';
import '../model/User/User.dart';
@Injectable(as: authenticationDataSource)
class authenticationDataSourceImp extends authenticationDataSource {
  Api_Manager apiManager;
  @factoryMethod authenticationDataSourceImp(this.apiManager);
  @override
  Future<User_api?> Register(String name, String email, String password,
      String rePassword, String phoneNumber) async{
    var response= await apiManager.register(name, email, password, rePassword, phoneNumber);
    return response.toUser();
  }
  Future<User_api?> Login(String email, String password) async{
    var response= await apiManager.login(email, password);
    return response.toUser();
  }
  Future<String?> ForgetPassword(String email) async{
    var response= await apiManager.ForgetPassword(email);
    return response.message;
  }
  Future<String?>ResetPasswordCode(String code) async{
    var response= await apiManager.ResetPasswordCode(code);

    return response;
  }
  Future<String?>ResetPassword(String email,String password) async{
    var response= await apiManager.ResetPassword(email, password);

    return response;
  }
}
