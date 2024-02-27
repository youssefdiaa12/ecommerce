import 'package:ecommerce/data/api_Manager.dart';
import 'package:ecommerce/data/model/User/UserCartList.dart';
import 'package:ecommerce/data/model/productResponse/ProductDto.dart';
import 'package:ecommerce/domain/useCase/WishListUseCase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:injectable/injectable.dart';
import '../../data/Services/disk_storage.dart';
import '../../data/model/User/FireBaseUser.dart';
import '../../data/model/User/User.dart';
import '../../data/model/User/user_cart_list_dao.dart';
import '../../data/model/productCartListResponse1/ProductCartListResponse1.dart';
import '../../data/model/productCartListResponse1/Products.dart';
import '../../domain/model/Product.dart';
import '../../domain/useCase/CartListUseCase.dart';
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
  TextEditingController searchController = TextEditingController();


  @factoryMethod  AppProvider(this.CartListdUseCases,this.cartListdUseCase);


  Future<bool> invoke_addToCart(
      String productId, String token, int count) async {
    try {
      var response =  await cartListdUseCase.invoke_addToCart(productId, token, count);
      if (response == "Product added successfully to your cart") {
       Product product=await getSpecificeProduct(productId);
        int val=product_cartList_count![productId]??0;
        val=val+count;
        UserCartList obj=UserCartList(productId,val);
        bool is_found=await CartListDao.is_found_task(obj,AppProvider.user_fire_base?.id??"");
        if(is_found){
          await CartListDao.editTask(obj,AppProvider.user_fire_base?.id??"");
        }
        else{
          await CartListDao.createTask(obj,AppProvider.user_fire_base?.id??"");
        }
       Products temp=Products(id:product.id,
    count: val,
    price: product.price,
    product: ProductDto(title: product.title,
    description: product.description,
    id: product.id,
    images: product.images,
    price: product.price,
    quantity: product.quantity,
    sold: product.sold,
    ratingsAverage: product.ratingsAverage,
    imageCover: product.imageCover,
    ));
       products_cartList?.add(temp);
       product_cartList_count![productId]=val;
      }
      notifyListeners();
      return true;
    }
    catch (e) {
      notifyListeners();
      return false;
    }
  }
  Future<void> register(String email, String name, String accssesToken, String phone,String pass) async {
    notifyListeners();
    saveUser(name, accssesToken, email, phone,"",pass);
    user = User_api(email: email, name: name, token: accssesToken,phone: phone,address: "",pass: pass);
  }
  Future<void> logout() async {
    await preferences?.clear();
    user = null;
    product_cartList_count={};
    products_cartList=[];
    products_wishList=[];
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


    return user?.email != null;
  }
  Future<dynamic> login(String name, String accssesToken, String email,String pass,String phone1 ,String address1) async {
    user = User_api(email: email, name: name, token: accssesToken,pass: pass,address:address1,phone:phone1);
    notifyListeners();
    saveUser(name, accssesToken, email, phone1,address1,pass);
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
    Api_Manager apiManager=Api_Manager();
    return await apiManager.getSpecificProduct_data(id);
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
    preferences = await SharedPreferences.getInstance();

    getUser();
  }
  bool isFavorite(String productId) {

    return products_wishList?.any((element) => element.id == productId) ?? false;
  }
  Future<String> addToFavorite(String productId) async{

    String? result=await CartListdUseCases.invoke_wish(productId, user?.token ?? "");
    if(result=="success"){
      products_wishList=await CartListdUseCases.invoke_getProductWishList(user?.token ?? "");
      notifyListeners();
    }
    return result??"";
  }
  Future<String> removeFromFavorite(String productId)async {
    String? result=await CartListdUseCases.invoke_removeFromwish(productId, user?.token ?? "");
    if(result=="success"){
      products_wishList=await CartListdUseCases.invoke_getProductWishList(user?.token ?? "");
      notifyListeners();
      //
    }
    return result??"";
  }
  Future<void> getProductList(String token) async{
    products_wishList=await CartListdUseCases.invoke_getProductWishList(token);
    notifyListeners();
  }
  Future<void> getCartList(String token) async{
    ProductCartListResponse1? response=await cartListdUseCase.invoke_getProductCartList(token);
    products_cartList=response?.data?.products??[];
    product_cartList_count?.clear();
   List<UserCartList> result=await CartListDao.getTasks(user_fire_base?.id??"");
    for(int i=0;i<(result.length);i++){
      product_cartList_count?.addAll({result[i].productId:result[i].quantity});
    }
    notifyListeners();
  }


}
