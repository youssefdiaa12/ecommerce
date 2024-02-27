import 'package:ecommerce/ui/payment/payment_form_body_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../Common/constant.dart';
import '../../viewModel/Payment/payment_cubit.dart';
import 'package:ecommerce/Common/dialogUtilities.dart';
import 'package:ecommerce/ui/payment/payment_card.dart';
import 'package:lottie/lottie.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:shimmer/shimmer.dart';
import '../../Common/customFormField.dart';
import '../../Common/validation.dart';
class PaymentFormBody extends StatefulWidget {
 final num amount;
  const PaymentFormBody({super.key, required this.amount});
  @override
  State<PaymentFormBody> createState() => _PaymentFormBodyState();
}
class _PaymentFormBodyState extends State<PaymentFormBody> {
  var keyform = GlobalKey<FormState>();
  TextEditingController userName = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var cubit=BlocProvider.of<PaymentCubit>(context);
    return  SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 30.h,),
          Center(child: Image.asset("assets/images/loginRoute.png")),
          BlocConsumer<PaymentCubit, PaymentState>(
            listener: (context, state) {
              if(state is SuccssesAuthPayment){
              }
              if(state is ErrorAuthPayment){
                dialogUtilites.lottieError(context, "Error");
              }
              if(state is LoadingTokenPaymentCard){
                dialogUtilites.lottieLoading(context, "Loading...");
              }
              if(state is ErrorTokenPaymentCard){
                Navigator.pop(dialogUtilites.dialogContext!);
                dialogUtilites.lottieError(context, "something went wrong");
              }
              if(state is LoadingTokenPaymentKiosk){
                dialogUtilites.lottieLoading(context, "Loading...");
              }
              if(state is SuccssesTokenPaymentCard){
                Navigator.pop(dialogUtilites.dialogContext!);

                PersistentNavBarNavigator.pushNewScreen(
                  context,
                  screen: PaymentCard(firstName: userName.text,
                      lastName: lastNameController.text,
                      email: emailController.text,
                      amount: widget.amount,
                      phoneNumber: phoneNumber.text
                  ),
                  withNavBar: false,
                );
              }
              if(state is ErrorTokenKiosk){
                Navigator.pop(dialogUtilites.dialogContext!);
                dialogUtilites.lottieError(context, "something went wrong");
              }
              if(state is ErrorReferenceCode){
                Navigator.pop(dialogUtilites.dialogContext!);
                dialogUtilites.lottieError(context, "something went wrong");
              }
             if(state is SuccssesReferenceCode){
               Navigator.pop(dialogUtilites.dialogContext!);
               Navigator.pop(context);
               showDialog(
                   context: context,
                   builder: (context) {
                     return AlertDialog(
                       shape:
                       RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                       //decrease height of the dialog
                       insetPadding:
                       EdgeInsets.symmetric(horizontal: 50.w, vertical: 300.h),
                       content:  Center(
                         child: Column(
                           mainAxisAlignment: MainAxisAlignment.center,
                           crossAxisAlignment: CrossAxisAlignment.center,
                           children: [
                             Lottie.asset(
                               'assets/animations/dollar.json',
                               fit: BoxFit.cover,
                               width:100.w,
                               height: 100.h
                             ),
                             SizedBox(height:10.h),
                             Text("Your Payment Code is",style: TextStyle(color: Theme.of(context).primaryColor),),
                             SizedBox(height:10.h),
                             Text(REFERENCE_CODE,style: TextStyle(color: Theme.of(context).primaryColor),),
                           ],
                         ),
                       ),
                     );
                   });

}
            },
            listenWhen:(previous, current) {
              if(current is SuccssesAuthPayment){
                return true;
              }
              if(current is ErrorAuthPayment){
                return true;
              }
              if(current is LoadingAuthenticationPayment){
                return true;
              }
              if(current is LoadingTokenPaymentCard){
                return true;
              }
              if(current is  ErrorTokenPaymentCard){
                return true;
              }
              if(current is  SuccssesTokenPaymentCard){
                return true;
              }
              if(current is LoadingTokenPaymentKiosk){
                return true;
              }
              if(current is  ErrorTokenKiosk){
                return true;
              }
              if(current is  SuccssesKiosk){
                return true;
              }
              if(current is  ErrorReferenceCode){
                return true;
              }
              if(current is SuccssesReferenceCode){
                return true;
              }
              if(current is LoadingReferenceCode){
                return true;
              }
              return false;
            },
            builder:(context, state) {
              if(state is SuccssesAuthPayment){
                return Form(
                  key: keyform,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomFormField(
                          userName,
                          "Enter your first name",
                          TextInputType.text,
                          false,
                              (value){
                            if(value!.isEmpty||value.length<3){
                              return
                                "Enter your first name";
                            }
                            return null;
                          },
                          "First Name",
                          lines: 1,
                        ),
                        SizedBox(height: 10.h,),
                        CustomFormField(
                          lastNameController,
                          "Enter your last name",
                          TextInputType.text,
                          false,
                              (value){
                            if(value!.isEmpty||value.length<3){
                              return "Enter your last name";
                            }
                            return null;
                          },
                          "Last name",
                          lines: 1,
                        ),
                        SizedBox(height: 10.h,),
                        CustomFormField(
                          phoneNumber,
                          "Enter your phone number",
                          TextInputType.phone,
                          false,
                              (value){
                            if(value!.isEmpty||value.length<11){
                              return "Enter your phone number";
                            }
                            return null;
                          },
                          "Phone Number",
                          lines: 1,
                        ),
                        SizedBox(height: 10.h,),
                        CustomFormField(
                          emailController,
                          "Enter your email address",
                          TextInputType.emailAddress,
                          false,
                              (value){
                            if(value!.isEmpty||!value.contains("@")||validation().isValidEmail(value)==false){
                              return "Enter your email address";
                            }
                            return null;
                          },
                          "Email",
                          lines: 1,
                        ),
                        SizedBox(height: 10.h,),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment:MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Total cost is",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize:20.sp,
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Container(
                                height: 50.h,
                                width: 130.w,
                                decoration: BoxDecoration(
                                  borderRadius:BorderRadius.circular(20),
                                  color: Colors.white,
                                  border: Border.all(color: const Color(0xffabc0d3), width: 1),
                                ),
                                child: Center(
                                  child: Text("${widget.amount} EGP",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xFF014282),
                                      fontSize:20.sp,
                                      fontFamily: "Poppins",
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10.h,),
                        Center(
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 12.w),
                            child: ElevatedButton(

                                style: ButtonStyle(

                                    backgroundColor: MaterialStateProperty.all(Colors.white),
                                    shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(12),
                                        )
                                    ),
                                    minimumSize: MaterialStateProperty.all(
                                      Size(double.infinity, 65.h),
                                    )
                                ),
                                onPressed: (){
                                  if(!formValidation()){
                                    return;
                                  }
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          shape:
                                          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                          //decrease height of the dialog
                                          insetPadding:
                                          EdgeInsets.symmetric(horizontal: 50.w, vertical: 250.h),
                                          content: SizedBox(
                                            width: 300.w,
                                            child: SingleChildScrollView(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Text("Choose your payment method",
                                                      style: TextStyle(
                                                        fontSize: 16.sp,
                                                        fontFamily: "Poppins",
                                                      )),
                                                  SizedBox(
                                                    height: 50.h,
                                                  ),
                                                  Row(
                                                      mainAxisAlignment:MainAxisAlignment.spaceAround,
                                                      children: [
                                                        InkWell(
                                                          onTap: ()async{
                                                            num amountString=widget.amount*100;
                                                            await cubit.getRequestTokenCard(userName.text, lastNameController.text,
                                                                emailController.text,
                                                                amountString.toString(),
                                                                phoneNumber.text
                                                            );
                                                          },
                                                          child: Lottie.asset(
                                                            'assets/animations/pc.json',
                                                            fit: BoxFit.cover,
                                                            height: 120.h,
                                                            width: 120.w,
                                                          ),
                                                        ),
                                                        InkWell(
                                                          onTap: () async{
                                                            num amountString=widget.amount*100;
                                                            await cubit.getRequestTokenKiosk(userName.text, lastNameController.text,
                                                                emailController.text,
                                                                amountString.toString(),
                                                                phoneNumber.text
                                                            );
                                                            await cubit.getRefernceCode();
                                                          },
                                                          child: Lottie.asset(
                                                            'assets/animations/pc1.json',
                                                            fit: BoxFit.cover,
                                                            height: 120.h,
                                                            width: 120.w,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 10.w,
                                                        )
                                                      ]
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      });
                                }, child: Text("Let's go",
                                style: TextStyle(
                                    color: const Color(0xFF014282),
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold
                                ))),
                          ),
                        ),
                        SizedBox(height: 10.h,),
                      ]
                  ),
                );

              }
              if(state is LoadingAuthenticationPayment){
                return Shimmer.fromColors(
                    baseColor: Colors.grey,
                    highlightColor: Colors.white,child:
                PaymentFormBodyCommon(amount:widget.amount)
                );
              }
              if(state is ErrorAuthPayment){
                return PaymentFormBodyCommon(amount:widget.amount);

              }
              return Form(
                key: keyform,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomFormField(
                        userName,
                        "Enter your first name",
                        TextInputType.text,
                        false,
                            (value){
                          if(value!.isEmpty||value.length<3){
                            return
                              "Enter your first name";
                          }
                          return null;
                        },
                        "First Name",
                        lines: 1,
                      ),
                      SizedBox(height: 10.h,),
                      CustomFormField(
                        lastNameController,
                        "Enter your last name",
                        TextInputType.text,
                        false,
                            (value){
                          if(value!.isEmpty||value.length<3){
                            return "Enter your last name";
                          }
                          return null;
                        },
                        "Last name",
                        lines: 1,
                      ),
                      SizedBox(height: 10.h,),
                      CustomFormField(
                        phoneNumber,
                        "Enter your phone number",
                        TextInputType.phone,
                        false,
                            (value){
                          if(value!.isEmpty||value.length<11){
                            return "Enter your phone number";
                          }
                          return null;
                        },
                        "Phone Number",
                        lines: 1,
                      ),
                      SizedBox(height: 10.h,),
                      CustomFormField(
                        emailController,
                        "Enter your email address",
                        TextInputType.emailAddress,
                        false,
                            (value){
                          if(value!.isEmpty||!value.contains("@")||validation().isValidEmail(value)==false){
                            return "Enter your email address";
                          }
                          return null;
                        },
                        "Email",
                        lines: 1,
                      ),
                      SizedBox(height: 10.h,),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment:MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Total cost is",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize:20.sp,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Container(
                              height: 50.h,
                              width: 130.w,
                              decoration: BoxDecoration(
                                borderRadius:BorderRadius.circular(20),
                                color: Colors.white,
                                border: Border.all(color: const Color(0xffabc0d3), width: 1),
                              ),
                              child: Center(
                                child: Text("${widget.amount} EGP",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFF014282),
                                    fontSize:20.sp,
                                    fontFamily: "Poppins",
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10.h,),
                      Center(
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 12.w),
                          child: ElevatedButton(

                              style: ButtonStyle(

                                  backgroundColor: MaterialStateProperty.all(Colors.white),
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      )
                                  ),
                                  minimumSize: MaterialStateProperty.all(
                                    Size(double.infinity, 65.h),
                                  )
                              ),
                              onPressed: (){
                                if(!formValidation()){
                                  return;
                                }
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        shape:
                                        RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                        //decrease height of the dialog
                                        insetPadding:
                                        EdgeInsets.symmetric(horizontal: 50.w, vertical: 250.h),
                                        content: SizedBox(
                                          width: 300.w,
                                          child: SingleChildScrollView(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Text("Choose your payment method",
                                                    style: TextStyle(
                                                      fontSize: 16.sp,
                                                      fontFamily: "Poppins",
                                                    )),
                                                SizedBox(
                                                  height: 50.h,
                                                ),
                                                Row(
                                                    mainAxisAlignment:MainAxisAlignment.spaceAround,
                                                    children: [
                                                      InkWell(
                                                        onTap: ()async{
                                                          num amountString=widget.amount*100;
                                                          await cubit.getRequestTokenCard(userName.text, lastNameController.text,
                                                              emailController.text,
                                                              amountString.toString(),
                                                              phoneNumber.text
                                                          );
                                                        },
                                                        child: Lottie.asset(
                                                          'assets/animations/pc.json',
                                                          fit: BoxFit.cover,
                                                          height: 120.h,
                                                          width: 120.w,
                                                        ),
                                                      ),
                                                      InkWell(
                                                        onTap: () async{
                                                          num amountString=widget.amount*100;
                                                          await cubit.getRequestTokenKiosk(userName.text, lastNameController.text,
                                                              emailController.text,
                                                              amountString.toString(),
                                                              phoneNumber.text
                                                          );
                                                          await cubit.getRefernceCode();
                                                        },
                                                        child: Lottie.asset(
                                                          'assets/animations/pc1.json',
                                                          fit: BoxFit.cover,
                                                          height: 120.h,
                                                          width: 120.w,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 10.w,
                                                      )
                                                    ]
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    });
                              }, child: Text("Let's go",
                              style: TextStyle(
                                  color: const Color(0xFF014282),
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold
                              ))),
                        ),
                      ),
                      SizedBox(height: 10.h,),
                    ]
                ),
              );
            },
          ),
        ],
      ),
    );
  }
  bool formValidation(){
    if(keyform.currentState!.validate()==false){
      return false;
    }
    return true;
  }

}
