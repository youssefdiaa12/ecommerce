import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../ui/Authentication/LoginScreen.dart';

class dialogUtilites {
  static BuildContext? dialogContext;

  static void hideDialog(BuildContext context, String msg,{VoidCallback? postAction}) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            content: SingleChildScrollView(
                child: Text(
              msg,
              style: TextStyle(color: Colors.black),
            )),
            actions: [
              TextButton(
                child: const Text(
                  'OK',
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () {
                  postAction?.call();
                },
              ),
            ],
          );
        });
  }

  static void lodingDialog(BuildContext context, String msg) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) {
          return AlertDialog(
            content: SingleChildScrollView(
                child: Row(
              children: [
                const CircularProgressIndicator(),
                const SizedBox(width: 4),
                Text(
                  msg,
                  style: const TextStyle(color: Colors.black),
                ),
              ],
            )),
          );
        });
  }

  static void showmsg(BuildContext context, String msg,
      {String pos = 'ok', VoidCallback? postAction, String? txt}) {
    showDialog(
      context: context,
      builder: (BuildContext buildcontext) {
        return AlertDialog(
          content: SingleChildScrollView(
              child: Text(
            msg,
            style: const TextStyle(color: Colors.black),
          )),
          actions: [
            TextButton(
              child: Text(
                pos,
                style: const TextStyle(color: Colors.black),
              ),
              onPressed: () {
                postAction?.call();
              },
            ),
            if (txt != null)
              TextButton(
                child: Text(
                  txt,
                  style: const TextStyle(color: Colors.black),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
          ],
        );
      },
    );
  }

  static void lottieError(BuildContext context, String msg) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            //decrease height of the dialog
            insetPadding:
                EdgeInsets.symmetric(horizontal: 30.w, vertical: 250.h),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Lottie.asset(
                    "assets/animations/error.json",
                    fit: BoxFit.cover,
                    height: 180.h,
                    width: 180.w,
                  ),
                  SizedBox(
                    height: 50.h,
                  ),
                  Text(msg,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontFamily: "Poppins",
                      )),
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Ok",
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ))
            ],
          );
        });
  }

  static void lottieLoading(BuildContext context, String msg) {
    showDialog(
        context: context,
        builder: (context) {
          dialogContext = context;
          return AlertDialog(
            insetPadding:
                EdgeInsets.symmetric(horizontal: 50.w, vertical: 250.h),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Lottie.asset(
                      "assets/animations/loading.json",
                      fit: BoxFit.cover,
                    ),
                  ),
                  Text(
                    "loading please wait...",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontFamily: "Poppins",
                    ),
                  ),
                  SizedBox(
                    height: 50.h,
                  ),
                ],
              ), //@
            ),
          );
        });
  }

  static void lottieLogin(BuildContext context, String msg) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            //decrease height of the dialog
            insetPadding:
                EdgeInsets.symmetric(horizontal: 30.w, vertical: 250.h),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Lottie.asset(
                    'assets/animations/requiredLogin.json',
                    fit: BoxFit.cover,
                    height: 180.h,
                    width: 180.w,
                  ),
                  SizedBox(
                    height: 50.h,
                  ),
                  Text(msg,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontFamily: "Poppins",
                      )),
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true)
                        .pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return const LoginScreen();
                        },
                      ),
                      (_) => false,
                    );
                  },
                  child: Text(
                    "Ok",
                    style: TextStyle(color: Color(0xff004182)),
                  ))
            ],
          );
        });
  }

  static void lottieVerify(BuildContext context, String msg) {
    showDialog(
        context: context,
        builder: (context) {
          dialogContext = context;
          return AlertDialog(
            insetPadding:
            EdgeInsets.symmetric(horizontal: 20.w, vertical: 250.h),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 50.h,),
                  Center(
                    child: Lottie.asset(
                      "assets/animations/codeSent.json",
                      height: 180.h,
                      width: 180.w,
                      fit: BoxFit.cover,
                    ),

                  ),
                  SizedBox(height: 50.h,),
                  Text(
                    msg,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontFamily: "Poppins",
                    ),
                  ),
                  SizedBox(
                    height: 50.h,
                  ),
                ],
              ), //@
            ),
          );
        });
  }

}
