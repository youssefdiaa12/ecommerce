import 'package:ecommerce/Common/customFormField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Common/validation.dart';

class PaymentFormBodyCommon extends StatelessWidget {
  final GlobalKey keyform = GlobalKey<FormState>();
  final num amount;
  final TextEditingController userName = TextEditingController();
  final TextEditingController phoneNumber = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  PaymentFormBodyCommon({super.key, required this.amount});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: keyform,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        CustomFormField(
          userName,
          "Enter your first name",
          TextInputType.text,
          false,
          (value) {
            if (value!.isEmpty || value.length < 3) {
              return "Enter your first name";
            }
            return null;
          },
          "First Name",
          lines: 1,
        ),
        SizedBox(
          height: 10.h,
        ),
        CustomFormField(
          lastNameController,
          "Enter your last name",
          TextInputType.text,
          false,
          (value) {
            if (value!.isEmpty || value.length < 3) {
              return "Enter your last name";
            }
            return null;
          },
          "Last name",
          lines: 1,
        ),
        SizedBox(
          height: 10.h,
        ),
        CustomFormField(
          phoneNumber,
          "Enter your phone number",
          TextInputType.phone,
          false,
          (value) {
            if (value!.isEmpty || value.length < 11) {
              return "Enter your phone number";
            }
            return null;
          },
          "Phone Number",
          lines: 1,
        ),
        SizedBox(
          height: 10.h,
        ),
        CustomFormField(
          emailController,
          "Enter your email address",
          TextInputType.emailAddress,
          false,
          (value) {
            if (value!.isEmpty ||
                !value.contains("@") ||
                validation().isValidEmail(value) == false) {
              return "Enter your email address";
            }
            return null;
          },
          "Email",
          lines: 1,
        ),
        SizedBox(
          height: 10.h,
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total cost is",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.sp,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                height: 50.h,
                width: 130.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.white,
                  border: Border.all(color: const Color(0xffabc0d3), width: 1),
                ),
                child: Center(
                  child: Text(
                    "$amount EGP",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF014282),
                      fontSize: 20.sp,
                      fontFamily: "Poppins",
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        Center(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 12.w),
            child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    )),
                    minimumSize: MaterialStateProperty.all(
                      Size(double.infinity, 65.h),
                    )),
                onPressed: () {
                  return;
                },
                child: Text("Let's go",
                    style: TextStyle(
                        color: const Color(0xFF014282),
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold))),
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
      ]),
    );
  }
}
