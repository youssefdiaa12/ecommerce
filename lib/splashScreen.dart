import 'package:animate_do/animate_do.dart';
import 'package:ecommerce/resources/responsive_ui_helper.dart';
import 'package:ecommerce/ui/home/homeSuccssesTap/homeScreen.dart';
import 'package:flutter/material.dart';

import 'di/di.dart';

class SplashPage extends StatefulWidget {
  static const routeName = 'splashScreen';
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Future.delayed(
      const Duration(seconds: 2),
          () {
        Navigator.pushReplacementNamed(context, hometap.routeName);
      },
    );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var size = getIt<ResponsiveUiConfig>()..initialize(context);



    return Scaffold(
      body: Container(
        width: size.screenWidth,
        height: size.screenHeight,
        color:Color(0xFF014282),

      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              "assets/images/Ellipse 6.png",
            ),
            FadeInLeft(
              duration: const Duration(seconds: 1),
              delay: const Duration(seconds: 1),
              child: Image.asset(
                "assets/images/loginRoute.png",
              ),
            ),
            Image.asset(
              "assets/images/Ellipse7.png",
            )
          ],
        ),
      ),
    );
  }
}
