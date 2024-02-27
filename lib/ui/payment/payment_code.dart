import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';

import '../../Common/constant.dart';

class PaymentCode extends StatefulWidget {
  final String firstName, lastName, email, phoneNumber;
  final num amount;
  const PaymentCode({super.key, required this.firstName, required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.amount});

  @override
  State<PaymentCode> createState() => _PaymentCodeState();
}

class _PaymentCodeState extends State<PaymentCode> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar:AppBar(
        leading: Container(),
        leadingWidth: 0,
        backgroundColor:const Color(0xFF014282),
        elevation:0,
        centerTitle:true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 6.0),
              child: Shimmer.fromColors(
                baseColor: Colors.white,
                highlightColor: Colors.grey,
                period: const Duration(seconds: 4),
                child: Text("Payment",
                    style: TextStyle(
                      fontSize:20.sp,
                      color: Colors.white,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w500,
                    )),
              ),
            ),
            SizedBox(width:10.w,),
            Lottie.asset("assets/animations/paymentCard.json",
                width: 50.w
                ,
                height: 50.h
            )

          ],
        ),
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/animations/dollar.json',
              fit: BoxFit.cover,
            ),
            Text("Your Payment Code is",style: TextStyle(color: Theme.of(context).primaryColor),),
            SizedBox(height:10.h),
            Text(REFERENCE_CODE,style: TextStyle(color: Theme.of(context).primaryColor),),
          ],
        ),
      ),
    );
  }
}
