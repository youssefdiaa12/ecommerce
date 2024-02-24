import '../../data/model/User/User.dart';

abstract class authenticationRepository {
  Future<User_api?> Register(String name, String email, String password,String rePassword, String phoneNumber);
Future<User_api?> Login(String email, String password);
Future<String?> ForgetPassword(String email);
Future<String?>ResetPasswordCode(String code);
Future<String?>ResetPassword(String email,String newPass);
}