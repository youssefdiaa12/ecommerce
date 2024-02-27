import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../Common/constant.dart';

class PaymentCard extends StatefulWidget {
  final String firstName, lastName, email, phoneNumber;
 final  num amount;
  const PaymentCard({super.key, required this.firstName, required this.lastName,
      required this.email,
      required this.phoneNumber,
      required this.amount});
  @override
  State<PaymentCard> createState() => _PaymentCardState();
}


class _PaymentCardState extends State<PaymentCard> {
  final Completer<WebViewController> _controller =Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
   // var cubit=BlocProvider.of<PaymentCubit>(context);
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
      body: WebView(
        initialUrl: 'https://accept.paymob.com/api/acceptance/iframes/827770?payment_token=$REQUEST_TOKEN_CARD',
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController){
          _controller.complete(webViewController);
        },
        navigationDelegate: (NavigationRequest request){
          if(request.url.startsWith('https://www.youtube.com/')){
            Navigator.pop(context);
          }
          return NavigationDecision.navigate;
        },
        onProgress:(int progress){
        },
        javascriptChannels: <JavascriptChannel>{
          _toasterJavascriptChannel(context),
        },
        onPageStarted: (String url){
        },
        onPageFinished: (String url){
        },
        backgroundColor: Colors.white,
      ),

    );
  }
  _toasterJavascriptChannel(BuildContext context){
    return JavascriptChannel(
      name: 'Toaster',
      onMessageReceived: (JavascriptMessage message){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message.message))
        );
      }
    );
  }
}
