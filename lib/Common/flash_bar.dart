import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

showFlushBar(
    String title,
    BuildContext context,
    {
      bool isError = true,
    }) {
  Flushbar(
    message: title,
    messageText: Text(
      title,
      style: TextStyle(color: Colors.white, fontSize: 16.sp),
      textAlign: TextAlign.center,
    ),
    flushbarPosition: FlushbarPosition.TOP,
    flushbarStyle: FlushbarStyle.FLOATING,
    backgroundColor: isError? Theme.of(context).primaryColor:Colors.green,
    shouldIconPulse: false,
    boxShadows: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.5),
        spreadRadius: 2,
        blurRadius: 7,
        offset: const Offset(0, 2),
      ),
    ],
    icon: isError
        ? const Icon(
      Icons.heart_broken_sharp,
      color: Colors.white,
      size: 20,
    )
        : const Icon(
      Icons.favorite_outlined,
      color: Colors.white,
      size: 20,
    ),
    duration: const Duration(seconds: 3),
    padding: const EdgeInsets.all(5),
    margin: const EdgeInsets.all(50),
    maxWidth: (70 / 100) * MediaQuery.of(context).size.width,
  ).show(context);
}