import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:injectable/injectable.dart';
import '../../data/model/User/User.dart';
import '../../domain/model/Product.dart';
import '../../domain/useCase/CartListUseCases.dart';
@singleton
class AppProvider extends ChangeNotifier {
  static User? user;
  List<Product>? products=[];
  SharedPreferences? preferences;
  CartListdUseCase CartListdUseCases;
  @factoryMethod  AppProvider(this.CartListdUseCases);
  Future<void> register(String email, String name, String accssesToken, String phone) async {
    notifyListeners();
    saveUser(name, accssesToken, email, phone);
  }
  Future<void> logout() async {
    preferences?.clear();
    user = null;
    // notifyListeners();
  }
  Future<bool> loggedin() async {
    await loadUser();
    print("ohyaah");
    print(user?.email);

    return user?.email != null;
  }
  Future<dynamic> login(String name, String accssesToken, String email) async {
    user = User(email: email, name: name, token: accssesToken);
    notifyListeners();
    saveUser(name, accssesToken, email, "");
    return user;}
  Future<void> saveUser(String name, String accssesToken, String email, String phone) async {
    await preferences?.setString("userName", name);
    await preferences?.setString("email", email);
    await preferences?.setString("accsses_token", accssesToken);
    await preferences?.setString("phone", phone);
  }
  Future<void> updateUserPassword(String password, String token) async {
    await preferences?.setString("password", password);
    await preferences?.setString("accsses_token", token);
  }
  void getUser() {
    user = User(
        email: preferences?.getString("email"),
        name: preferences?.getString("userName"),
        token: preferences?.getString("accsses_token"),
    phone: preferences?.getString("phone")
    );
    notifyListeners();
  }
  Future<void> loadUser() async {
    print("user is loaded");
    preferences = await SharedPreferences.getInstance();
    getUser();
  }
  bool isFavorite(String productId) {

    return products?.any((element) => element.id == productId) ?? false;
  }
  Future<String> addToFavorite(String productId) async{
    String? result=await CartListdUseCases.invoke_addToCart(productId, user?.token ?? "");
    if(result=="success"){
      products?.add(Product(id: productId));
      //await CartListdUseCases.invoke_getProductList(user?.token ?? "");
    }
    return result??"";
  }
  Future<String> removeFromFavorite(String productId)async {
    String? result=await CartListdUseCases.invoke_removeFromCart(productId, user?.token ?? "");
    if(result=="success"){
      products?.removeWhere((element) => element.id == productId);
      print("lol");
      print(products?.length);
      notifyListeners();
      //await CartListdUseCases.invoke_getProductList(user?.token ?? "");
    }
    return result??"";
  }
  Future<void> getProductList(String token) async{
    products=await CartListdUseCases.invoke_getProductList(token);
    print("loliiii");
    print(products?.length);
    notifyListeners();
  }
}
//bf376d3cbdbf47c9a8c4bf1ef7d27f8a
