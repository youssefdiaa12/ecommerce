import 'dart:convert';
import 'package:ecommerce/data/model/brandResponse/BrandResponse.dart';
import 'package:ecommerce/data/model/categoriesResponse/CategoryResponse.dart';
import 'package:ecommerce/domain/repository/productRepository.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'model/AddToCartListResponse/AddToCartListResponse.dart';
import 'model/CartListResponse/CartListResponse.dart';
import 'model/ProductCartListResponse/ProductCartListResponse.dart';
import 'model/UpdateCartListResponse/UpdateCartListResponse.dart';
import 'model/authenticationResponse/ForgetPasswordResponse.dart';
import 'model/authenticationResponse/RegisterResponse.dart';
import 'model/authenticationResponse/ResetPasswordCodeResponse.dart';
import 'model/authenticationResponse/ResetPasswordResponse.dart';
import 'model/productResponse/ProductDto.dart';
import 'model/productResponse/ProductResponse.dart';
import 'model/requests/LoginRequest.dart';
import 'model/requests/ProductIdRequest.dart';
import 'model/requests/RegisterationRequest.dart';
import 'model/requests/forgetPasswordRequest.dart';
import 'model/requests/productCountRequest.dart';
import 'model/requests/resetPasswordRequest.dart';
import 'model/requests/verfiyResetPasswordRequest.dart';

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
    var cartListResponse=AddToCartListResponse.fromJson(jsonDecode(response.body));
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
    var cartListResponse=AddToCartListResponse.fromJson(jsonDecode(response.body));
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
    var cartListResponse=CartListResponse.fromJson(jsonDecode(response.body));
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
    var cartListResponse=UpdateCartListResponse.fromJson(jsonDecode(response.body));
    print("updated");
    print(cartListResponse.status);
    return cartListResponse.status;
  }
  Future<ProductCartListResponse?>getCartListResponse(String token)async{
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
    var cartListResponse=ProductCartListResponse.fromJson(jsonDecode(response.body));
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
    var cartListResponse=AddToCartListResponse.fromJson(jsonDecode(response.body));
    print("added");
    print(cartListResponse.status);
  }

}
