import 'dart:convert';
import 'package:ecommerce/data/model/brandResponse/BrandResponse.dart';
import 'package:ecommerce/data/model/categoriesResponse/CategoryResponse.dart';
import 'package:ecommerce/domain/model/Product.dart';
import 'package:ecommerce/domain/repository/productRepository.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'model/AddToCartListResponse/AddToCartListResponse.dart';
import 'model/AddWishListResponse/AddWishListResponse.dart';
import 'model/RemoveFromCartListResponse/RemoveFromCartListResponse.dart';
import 'model/UpdateCartListResponse/UpdateCarrtListResponse.dart';
import 'model/UpdateLoggedUserDataResponse/UpdateLoggedUserDataResponse.dart';
import 'model/WishListResponse/WishListResponse.dart';
import 'model/authenticationResponse/ForgetPasswordResponse.dart';
import 'model/authenticationResponse/RegisterResponse.dart';
import 'model/authenticationResponse/ResetPasswordCodeResponse.dart';
import 'model/authenticationResponse/ResetPasswordResponse.dart';
import 'model/productCartListResponse1/ProductCartListResponse1.dart';
import 'model/productResponse/ProductDto.dart';
import 'model/productResponse/ProductResponse.dart';
import 'model/requests/LoginRequest.dart';
import 'model/requests/ProductIdRequest.dart';
import 'model/requests/RegisterationRequest.dart';
import 'model/requests/UpdateLoggedUserDataRequest.dart';
import 'model/requests/UpdatePassRequest.dart';
import 'model/requests/forgetPasswordRequest.dart';
import 'model/requests/productCountRequest.dart';
import 'model/requests/resetPasswordRequest.dart';
import 'model/requests/verfiyResetPasswordRequest.dart';
import 'model/speceficProductResponse/SpeceficProductResponse.dart';
import 'model/updateLoggedUserPassword/UpdateLoggedUserPassword.dart';

@singleton
@injectable
class Api_Manager {
  String BaseUrl = "ecommerce.routemisr.com";

  Future<CategoryResponse> getCategories() async {
    var uri = Uri.https(BaseUrl, "/api/v1/categories");
    try {
      var response = await http.get(uri);
      var categoriesList = CategoryResponse.fromJson(jsonDecode(response.body));
      return categoriesList;
    } catch (e) {
      print(e);
      var response = await http.get(uri);
      var categoriesList = CategoryResponse.fromJson(jsonDecode(response.body));
      return categoriesList;
    }
  }

  Future<BrandResponse> getBrands() async {
    var uri = Uri.https(BaseUrl, "/api/v1/brands");
    var response = await http.get(uri);
    var BrandsList = BrandResponse.fromJson(jsonDecode(response.body));
    return BrandsList;
  }

  Future<ProductResponse> getProducts(int pageNo, int limit,
      {ProductSortBy? productSortBy, String? categoryid}) async {
    var params = {
      "page": pageNo.toString(),
      "limit": limit.toString(),
      "sort": productSortBy?.sort ?? "",
    };
    if (categoryid != null && categoryid.isNotEmpty) {
      params["category[in]"] = categoryid;
    }
    var uri = Uri.https(BaseUrl, "/api/v1/products", params);
    var response = await http.get(uri);
    var ProductsList = ProductResponse.fromJson(jsonDecode(response.body));
    print(ProductsList.data!.length);
    return ProductsList;
  }

  Future<num?> getSpecificProduct(String productId) async {

    var uri = Uri.https(BaseUrl, "/api/v1/products/$productId");
    var response = await http.get(uri);

    var ProductsList = SpeceficProductResponse.fromJson(jsonDecode(response.body));
    print(ProductsList.data!.price);

    return ProductsList.data!.price;
  }
  Future<Product> getSpecificProduct_data(String productId) async {

    var uri = Uri.https(BaseUrl, "/api/v1/products/$productId");
    var response = await http.get(uri);

    var ProductsList = SpeceficProductResponse.fromJson(jsonDecode(response.body));
    return ProductsList.data?.toProduct()??Product();

  }

  Future<RegisterResponse> register(String name, String email, String password,
      String rePassword, String phoneNumber) async {
    var uri = Uri.https(BaseUrl, "/api/v1/auth/signup");
    var requestBody = RegisterationRequest(
        name: name,
        email: email,
        password: password,
        rePassword: rePassword,
        phone: phoneNumber);
    var response = await http.post(
      uri,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(requestBody.toJson()),
    );
    print(response.body);
    var registerResponse = RegisterResponse.fromJson(jsonDecode(response.body));
    return registerResponse;
  }

  Future<RegisterResponse> login(String email, String password) async {
    var uri = Uri.https(BaseUrl, "/api/v1/auth/signin");
    var requestBody = LoginRequest(
      email: email,
      password: password,
    );
    var response = await http.post(uri,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(requestBody.toJson()));
    print(response.body);
    var registerResponse = RegisterResponse.fromJson(jsonDecode(response.body));
    return registerResponse;
  }

  Future<ForgetPasswordResponse> ForgetPassword(String email) async {
    var uri = Uri.https(BaseUrl, "/api/v1/auth/forgotPasswords");
    var requestBody = forgetPasswordRequest(
      email: email,
    );
    var response = await http.post(uri,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(requestBody.toJson()));
    print(response.body);
    var forgetPasswordResponse =
        ForgetPasswordResponse.fromJson(jsonDecode(response.body));
    return forgetPasswordResponse;
  }

  Future<String?> ResetPasswordCode(String code) async {
    print(code);
    var uri = Uri.https(BaseUrl, "/api/v1/auth/verifyResetCode");
    var requestBody = verfiyResetPasswordRequest(
      resetCode: code,
    );
    var response = await http.post(uri,
        headers: {
          "Content-Type": "application/json",
          "Accept": "*/*",
          "Accept-Encoding": "gzip, deflate, br",
          "Connection": "keep-alive",
          "Host": "ecommerce.routemisr.com",
        },
        body: jsonEncode(requestBody.toJson()));
    print(response.body);
    print("lol");
    var resetPasswordResponse =
        ResetPasswordCodeResponse.fromJson(jsonDecode(response.body));
    String status;
    if (resetPasswordResponse.status != null) {
      status = resetPasswordResponse.status!;
    } else {
      status = "Error";
    }
    print(status);
    return status;
  }

  Future<String?> ResetPassword(String email, String password) async {
    var uri = Uri.https(BaseUrl, "/api/v1/auth/resetPassword");
    var requestBody = resetPasswordRequest(
      email: email,
      newPassword: password,
    );
    var response = await http.put(uri,
        headers: {
          "Content-Type": "application/json",
          "Accept": "*/*",
          "Accept-Encoding": "gzip, deflate, br",
          "Connection": "keep-alive",
        },
        body: jsonEncode(requestBody.toJson()));
    print(response.body);
    var resetPasswordResponse = ResetPasswordResponse.fromJson(jsonDecode(response.body));
    String status;
    if (resetPasswordResponse.token != null) {
      status = resetPasswordResponse.token!;
    }
    else {

      status = "Error";
    }
    print(status);
    return status;
  }

  Future<String?> addProductToWishList(String productId, String token) async {
    var uri = Uri.https(BaseUrl, "/api/v1/wishlist");
    var requestBody =ProductIdRequest(
      productId: productId,
    );
    var response = await http.post(uri,
        headers: {
          "Content-Type": "application/json",
          "Accept": "*/*",
          "Accept-Encoding": "gzip, deflate, br",
          "Connection": "keep-alive",
          "token": "$token",
        },
        body: jsonEncode(requestBody.toJson()));
    print(response.body);
    var cartListResponse=AddWishListResponse.fromJson(jsonDecode(response.body));
    return cartListResponse.status;
  }
  Future<String?> removeProductToWishList(String productId, String token) async {
    var uri = Uri.https(BaseUrl, "/api/v1/wishlist/$productId");
    var response = await http.delete(uri,
        headers: {
          "Content-Type": "application/json",
          "Accept": "*/*",
          "Accept-Encoding": "gzip, deflate, br",
          "Connection": "keep-alive",
          "token": "$token",
        },
       );
    var cartListResponse=AddWishListResponse.fromJson(jsonDecode(response.body));
    print("removed");
    print(cartListResponse.status);
    return cartListResponse.status;
  }
  Future<List<ProductDto>?> getProductList(String token) async {
    print("token");
    print(token);
    var uri = Uri.https(BaseUrl, "/api/v1/wishlist");
    var response = await http.get(uri,
      headers: {
        "Content-Type": "application/json",
        "Accept": "*/*",
        "Accept-Encoding": "gzip, deflate, br",
        "Connection": "keep-alive",
        "token": "$token",
      },
    );
    print(response.body);
    var cartListResponse=WishListResponse.fromJson(jsonDecode(response.body));
    print("cartListResponse");

    print(cartListResponse.status);
    return cartListResponse.data;
  }
Future<String?>addProductToCartList(String productId, String token) async {
    print("${token}");
  var uri = Uri.https(BaseUrl, "/api/v1/cart");
  var requestBody =ProductIdRequest(
    productId: productId,
  );

  var response = await http.post(uri,
    headers: {
      "Content-Type": "application/json",
      "Accept": "*/*",
      "Accept-Encoding": "gzip, deflate, br",
      "Connection": "keep-alive",
      "token": "$token",
    },
    body: jsonEncode(requestBody.toJson()),
  );
  var cartListResponse=AddToCartListResponse.fromJson(jsonDecode(response.body));
  print("added");
  print(cartListResponse.status);
  print(cartListResponse.message);
  return cartListResponse.message;
}
  Future<String?>UpdateProductToCartList(String productId, String token,int count) async {
    var uri = Uri.https(BaseUrl, "/api/v1/cart/$productId");
var requestBody=ProductCountRequest(
  count: count.toString(),
);
    var response = await http.put(uri,
      headers: {
        "Content-Type": "application/json",
        "Accept": "*/*",
        "Accept-Encoding": "gzip, deflate, br",
        "Connection": "keep-alive",
        "token": "$token",
      },
      body: jsonEncode(requestBody.toJson()),
    );
    print("55555");
    try{
    var cartListResponse=UpdateCarrtListResponse.fromJson(jsonDecode(response.body));
    print("updated");
    print(cartListResponse.status);
    return cartListResponse.status;
    }
    catch(e){
      print(e);
      return "Error";
    }
  }
  Future<ProductCartListResponse1?>getCartListResponse(String token)async{
    var uri = Uri.https(BaseUrl, "/api/v1/cart");
    var response = await http.get(uri,
      headers: {
        "Content-Type": "application/json",
        "Accept": "*/*",
        "Accept-Encoding": "gzip, deflate, br",
        "Connection": "keep-alive",
        "token": "$token",
      }
    );
    print(response.body);
    var cartListResponse;
    try {
       cartListResponse = ProductCartListResponse1.fromJson(
          jsonDecode(response.body));
    }
    catch(e){
      print(e);
    }
    print("cartListResponse");
    print(cartListResponse.data);
    return cartListResponse;
  }
  Future<String?>removeFromCartList(String productId, String token)async{
    var uri = Uri.https(BaseUrl, "/api/v1/cart/$productId");
    var response = await http.delete(uri,
      headers: {
        "Content-Type": "application/json",
        "Accept": "*/*",
        "Accept-Encoding": "gzip, deflate, br",
        "Connection": "keep-alive",
        "token": "$token",
      }
    );
    print("kkkk");
    var cartListResponse=RemoveFromCartListResponse.fromJson(jsonDecode(response.body));
    print("deleted");
    print(cartListResponse.status);
    return cartListResponse.status;
  }
  Future<String>updateUserData(String name ,String email,String phoneNumber,String token)async{
    print("$name $email $phoneNumber $token");
    var uri = Uri.https(BaseUrl, "/api/v1/users/updateMe/");
    var requestBody=UpdateLoggedUserDataRequest(
      name: name,
      email: email,
      phone: phoneNumber,
    );
    var response = await http.put(uri,
      headers: {
        "Content-Type": "application/json",
        "Accept": "*/*",
        "Accept-Encoding": "gzip, deflate, br",
        "Connection": "keep-alive",
        "token": "$token",
      },
      body: jsonEncode(requestBody.toJson()),
    );
    try{
      var cartListResponse=UpdateLoggedUserDataResponse.fromJson(jsonDecode(response.body));
      print("updated");
      print(response.body);
      print(cartListResponse.message);
      String?status=cartListResponse.message;
      if(status=="fail"){
        Map<String, dynamic> jsonBody = json.decode(response.body);
        String status = jsonBody['errors']['msg'];
        print(status);
        return status;
      }
      return cartListResponse.message??"";
    }
    catch(e){
      print(e);
      return "Error";
    }
  }
  Future<String>updatePassword(String currentPass,String password,String token)async{
    var uri = Uri.https(BaseUrl, "/api/v1/users/changeMyPassword");
    var requestBody=UpdatePassRequest(
      password: password,
      rePassword: password,
      currentPassword: currentPass,
    );
    var response = await http.put(uri,
      headers: {
        "Content-Type": "application/json",
        "Accept": "*/*",
        "Accept-Encoding": "gzip, deflate, br",
        "Connection": "keep-alive",
        "token": "$token",
      },
      body: jsonEncode(requestBody.toJson()),
    );
    try{
      var cartListResponse=UpdateLoggedUserPassword.fromJson(jsonDecode(response.body));
      print("updated");
      print(response.body);
      print(cartListResponse.message);
      return cartListResponse.token??"Error";
    }
    catch(e){
      print(e);
      return "Error";
    }
  }

}
