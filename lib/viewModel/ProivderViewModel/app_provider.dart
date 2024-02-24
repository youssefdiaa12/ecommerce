import 'package:ecommerce/data/api_Manager.dart';
import 'package:ecommerce/data/model/User/UserCartList.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:injectable/injectable.dart';
import '../../data/model/User/FireBaseUser.dart';
import '../../data/model/User/UseDaoFireBase.dart';
import '../../data/model/User/User.dart';
import '../../data/model/User/user_cart_list_dao.dart';
import '../../data/model/productCartListResponse1/ProductCartListResponse1.dart';
import '../../data/model/productCartListResponse1/Products.dart';
import '../../domain/model/Product.dart';
import '../../domain/useCase/CartListUseCase.dart';
import '../../domain/useCase/WishListUseCases.dart';
@singleton
class AppProvider extends ChangeNotifier {
  static User_api? user;
  List<Product>? products_wishList=[];
  List<Products>? products_cartList=[];
  Map<String,int>?product_cartList_count={};
 static FireBaseUser? user_fire_base;
  SharedPreferences? preferences;
  WishListdUseCase CartListdUseCases;
  CartListdUseCase cartListdUseCase;

  @factoryMethod  AppProvider(this.CartListdUseCases,this.cartListdUseCase);
  Future<void> register(String email, String name, String accssesToken, String phone,String pass) async {
    notifyListeners();
    saveUser(name, accssesToken, email, phone,"",pass);
    user = User_api(email: email, name: name, token: accssesToken,phone: phone,address: "",pass: pass);
  }
  Future<void> logout() async {
    print("logOut");
    preferences?.clear();
    print(preferences?.get("email"));
    user = null;
    await FirebaseAuth.instance.signOut();
    user_fire_base=null;
    notifyListeners();
    // notifyListeners();
  }
  void update_counter_product(String id,int count){
    product_cartList_count![id]=count;
    notifyListeners();
  }
  Future<bool> loggedin() async {
    await loadUser();
    print("ohyaah");
    print(user?.email);
    print(user?.pass);

    return user?.email != null;
  }
  Future<dynamic> login(String name, String accssesToken, String email,String pass) async {
    print("ypur bass");
    print(pass);
    user = User_api(email: email, name: name, token: accssesToken,pass: pass,address: "",phone: "");
    notifyListeners();
    saveUser(name, accssesToken, email, "","",pass);
    return user;}
  Future<void> saveUser(String name, String accssesToken, String email, String phone,String address,String pass) async {
    await preferences?.setString("userName", name);
    await preferences?.setString("email", email);
    await preferences?.setString("accsses_token", accssesToken);
    await preferences?.setString("phone", phone);
    await preferences?.setString("address",address);
    await preferences?.setString("password", pass);
  }
  Future<void> updateUserPassword(String password, String token) async {
    await preferences?.setString("password", password);
    await preferences?.setString("accsses_token", token);
  }
  Future<Product>getSpecificeProduct(String id)async{
    Api_Manager api_manager=Api_Manager();
    return await api_manager.getSpecificProduct_data(id);
  }

  void getUser() {
    user = User_api(
        email: preferences?.getString("email"),
        name: preferences?.getString("userName"),
        token: preferences?.getString("accsses_token"),
    phone: preferences?.getString("phone")??"",
    address: preferences?.getString("address")??"",
      pass: preferences?.getString("password")??""
    );
    notifyListeners();
  }
  Future<void> loadUser() async {
    print("user is loaded");
    preferences = await SharedPreferences.getInstance();
  var  firebaseauth = FirebaseAuth.instance.currentUser;
    if (firebaseauth != null) {
      user_fire_base = await UserDaoFireBase.getuser(firebaseauth.uid);
      print(firebaseauth.uid);
    }
    getUser();
  }
  bool isFavorite(String productId) {

    return products_wishList?.any((element) => element.id == productId) ?? false;
  }
  Future<String> addToFavorite(String productId) async{

    String? result=await CartListdUseCases.invoke_wish(productId, user?.token ?? "");
    if(result=="success"){
      products_wishList=await CartListdUseCases.invoke_getProductWishList(user?.token ?? "");
    }
    return result??"";
  }
  Future<String> removeFromFavorite(String productId)async {
    String? result=await CartListdUseCases.invoke_removeFromwish(productId, user?.token ?? "");
    if(result=="success"){
      products_wishList=await CartListdUseCases.invoke_getProductWishList(user?.token ?? "");
      print("lol");
      print(products_wishList?.length);
      notifyListeners();
      //
    }
    return result??"";
  }
  Future<void> getProductList(String token) async{
    products_wishList=await CartListdUseCases.invoke_getProductWishList(token);
    print(products_wishList?.length);
    notifyListeners();
  }
  Future<void> getCartList(String token) async{
    ProductCartListResponse1? response=await cartListdUseCase.invoke_getProductCartList(token);
    products_cartList=response?.data?.products??[];
    print("ur cart list is");
    print(products_cartList?.length);
    product_cartList_count?.clear();
   List<UserCartList> result=await CartListDao.getTasks(user_fire_base?.id??"");
   print(result.length);
   print("jojo");
    for(int i=0;i<(result.length);i++){
      print(result[i].productId);
      product_cartList_count?.addAll({result[i].productId:result[i].quantity});
    }
    notifyListeners();
  }


}
//bf376d3cbdbf47c9a8c4bf1ef7d27f8a
