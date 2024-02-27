import 'package:dio/dio.dart';

class  DioHelper{

 static late Dio dio;

 static void init() {
   dio = Dio(BaseOptions(baseUrl: "https://accept.paymob.com/api/",
    receiveDataWhenStatusError: true,));
 }
static Future<dynamic> postData(String url,Map<String,dynamic>data)async{
  DioHelper.init();
  return await dio.post(url,data: data);
}

}