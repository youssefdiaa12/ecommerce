import 'package:bloc/bloc.dart';
import 'package:ecommerce/domain/model/Product.dart';
import 'package:ecommerce/resources/app_themes.dart';
import 'package:ecommerce/resources/blocObserver.dart';
import 'package:ecommerce/splashScreen.dart';
import 'package:ecommerce/ui/Authentication/LoginScreen.dart';
import 'package:ecommerce/ui/Authentication/Register.dart';
import 'package:ecommerce/ui/Authentication/forgetPasswordWidget.dart';
import 'package:ecommerce/ui/Authentication/resetPasswordWidget.dart';
import 'package:ecommerce/ui/Authentication/verifyResetPasswordWidget.dart';
import 'package:ecommerce/ui/home/CartList/CartListWidget.dart';
import 'package:ecommerce/ui/home/CategoriesTap/categoryProductsWidget.dart';
import 'package:ecommerce/ui/home/CategoriesTap/productDetailsCartWidget.dart';
import 'package:ecommerce/ui/home/homeSuccssesTap/homeScreen.dart';
import 'package:ecommerce/viewModel/ProivderViewModel/app_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'di/di.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  configureDependencies();
  var provider1 = getIt<AppProvider>();
  await provider1.loggedin()?await provider1.getProductList(AppProvider.user?.token??""):null;
  if(AppProvider.user?.email!=null){
    await provider1.getCartList(AppProvider.user?.token??"");
  }
  runApp(
      ChangeNotifierProvider(create: (context) => provider1, child: const MyApp()),
  );

  }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  ResponsiveSizer(
      builder: (context, orientation, screenType) =>
      ScreenUtilInit(
        designSize: const Size(430, 932),
        minTextAdapt: true,
        splitScreenMode: true,
        child: MaterialApp(
          debugShowMaterialGrid: false,
          showSemanticsDebugger: false,
          theme:MyThemeData.lightTheme,
          debugShowCheckedModeBanner: false,
          initialRoute:   SplashPage.routeName,
          routes: {
            hometap.routeName:(context)=>const hometap(),
            categorProductsWidget.routeName:(context)=>const categorProductsWidget(),
            LoginScreen.routeName:(context)=> const LoginScreen(),
            SplashPage.routeName:(context)=>const SplashPage(),
            Register.routeName:(context)=>const Register(),
            verifyResetPasswordWidget.routeName:(context)=> verifyResetPasswordWidget(email: ""),
            forgetPasswordWidget.routeName:(context)=>const forgetPasswordWidget(),
            resetPasswordWidget.routeName:(context)=>resetPasswordWidget(email:""),
            productDetailsCartWidget.routeName:(context)=> productDetailsCartWidget(Product()),
            CartListWidget.routeName:(context)=> CartListWidget(),
          },
        ),
      ),
    );
  }
}

