import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class requiredLoginWidget extends StatefulWidget {
VoidCallback? onPressed;
String? text;
requiredLoginWidget({Key? key, this.onPressed, this.text}) : super(key: key);
  @override
  State<requiredLoginWidget> createState() => _requiredLoginWidgetState();
}

class _requiredLoginWidgetState extends State<requiredLoginWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Text("Please Login First"),
          Lottie.asset('assets/animations/requiredLogin.json'),
          ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  )
                )
              ),

              onPressed: widget.onPressed, child: Text(widget.text!,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.sp,
              fontWeight: FontWeight.bold
            )))
        ]
      ),
    );
  }
}
