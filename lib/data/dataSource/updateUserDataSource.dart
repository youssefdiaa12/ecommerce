abstract class updateUserDataSource{
  Future<String> updateUser(String name, String email, String phone, String token);
  Future<String> updateUserPass(String currentPass,String password, String token);


}