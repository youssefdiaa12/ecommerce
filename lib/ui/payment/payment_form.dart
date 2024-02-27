import 'package:ecommerce/di/di.dart';
import 'package:ecommerce/ui/payment/payment_form_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';

import '../../viewModel/Payment/payment_cubit.dart';

class PaymentForm extends StatefulWidget {
  final num amount;
  const PaymentForm({super.key, required this.amount});
  @override
  State<PaymentForm> createState() => _PaymentFormState();
}
class _PaymentFormState extends State<PaymentForm> {


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      getIt<PaymentCubit>()
        ..getAuth(),
      child: Scaffold(
        backgroundColor: const Color(0xFF014282),
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
        body: PaymentFormBody(amount:widget.amount),
      ),
    );
  }
}
