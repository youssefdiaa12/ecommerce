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
      backgroundColor: const Color(0xFF014282),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/Ellipse 6.png",
            fit: BoxFit.cover,
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.3,
          ),
          Center(
            child: Align(
              alignment: Alignment.center,
              child: FadeInLeft(
                duration: const Duration(seconds: 1),
                delay: const Duration(seconds: 1),
                child: Image.asset(
                  "assets/images/loginRoute.png",
                  fit: BoxFit.cover,
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
              ),
            ),
          ),
          Image.asset(
            scale: 0.8,
            "assets/images/Ellipse7.png",
            fit: BoxFit.cover,
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.3,
          ),
        ],
      ),
    );
  }
}
