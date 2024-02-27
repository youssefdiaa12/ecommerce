import 'package:ecommerce/Common/dialogUtilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../Common/customFormFieldForAccount.dart';
import '../../../Common/validation.dart';
import '../../../viewModel/ProivderViewModel/app_provider.dart';
import '../../../viewModel/updateUserDataViewModel/update_user_data_cubit.dart';

class MyAccountBody extends StatefulWidget {
  MyAccountBody();
  @override
  State<MyAccountBody> createState() => _MyAccountBodyState();
}

class _MyAccountBodyState extends State<MyAccountBody> {
  var keyform = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

  }
  @override
  Widget build(BuildContext context) {

    AppProvider provider1 = Provider.of<AppProvider>(context);

    var cubit = BlocProvider.of<UpdateUserDataCubit>(context);
    return  SingleChildScrollView(
      child: Form(
        key: keyform,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Text("Welcome, ",style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 18.sp,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w500,
                  )),
                  Text("${AppProvider.user?.name}",style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 18.sp,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w500,
                  ))
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              Text("${AppProvider.user?.email}",style: TextStyle(
                fontSize: 14.sp,
                fontFamily: "Poppins",
                fontWeight: FontWeight.w400,
                color: Color(0xff8e8bae),
              )),
              SizedBox(
                height: 20.h,
              ),
              Text("Your Full Name",style: TextStyle(
                fontSize: 18.sp,
                fontFamily: "Poppins",
                fontWeight: FontWeight.w500,
                color: Theme.of(context).primaryColor,
              )),
              customFormFieldForAccount(cubit.nameController, "Full Name",
                  TextInputType.name,(p0) {
                if(p0!.isEmpty){
                  return "Name can't be empty";
                }
                return null;
                  },
                  false,
                  AppProvider.user?.name,idx:0
              , onChanged: (value) {
                  cubit.nameController.text = value;
                },),
              SizedBox(
                height: 20.h,
              ),
              Text("Your E-mail",style: TextStyle(
                fontSize: 18.sp,
                fontFamily: "Poppins",
                fontWeight: FontWeight.w500,
                color: Theme.of(context).primaryColor,
              )),
              customFormFieldForAccount(cubit.emailController, "E-mail",
                  TextInputType.emailAddress,(p0) {
                    if(p0!.isEmpty){
                      return "Email can't be empty";
                    }
                    if(validation().isValidEmail(p0)==false){
                      return "Enter a valid email address";
                    }
                    return null;
                  },
                  false,
                  AppProvider.user?.email,idx:1,
                onChanged: (value) {
                  cubit.emailController.text = value;
                },),
              SizedBox(
                height: 20.h,
              ),
              Text("Your Password",style: TextStyle(
                fontSize: 18.sp,
                fontFamily: "Poppins",
                fontWeight: FontWeight.w500,
                color: Theme.of(context).primaryColor,
              )),
              customFormFieldForAccount(cubit.passwordController, "Password",
                  TextInputType.visiblePassword,(p0) {
                    if(p0!.isEmpty){
                      return "Paasword can't be empty";
                    }
                    if(p0.length<6){
                      return "password must be at least 6 characters";
                    }
                    return null;
                  },
                  true,
                  AppProvider.user?.pass,idx:2,
                onChanged: (value) {
                  cubit.passwordController.text = value;
                },),
              SizedBox(
                height: 20.h,
              ),
              Text("Your Mobile number",style: TextStyle(
                fontSize: 18.sp,
                fontFamily: "Poppins",
                fontWeight: FontWeight.w500,
                color: Theme.of(context).primaryColor,
              )),
              customFormFieldForAccount(cubit.phoneController, "Phone number",
                  TextInputType.visiblePassword,(p0) {
                print("jjjj");
                print(p0);
                    if(p0!.isEmpty){
                      return "phone number can't be empty";
                    }
                    if(p0.length!=11){
                      return "Enter a valid phone number";
                    }
                    return null;
                  },
                  false,
                  AppProvider.user?.phone,idx:3,
                onChanged: (value) {
                  cubit.phoneController.text = value;
                },),
              SizedBox(
                height: 20.h,
              ),
              Text("Your Address",style: TextStyle(
                fontSize: 18.sp,
                fontFamily: "Poppins",
                fontWeight: FontWeight.w500,
                color: Theme.of(context).primaryColor,
              )),
              customFormFieldForAccount(cubit.addressController, "Address",
                  TextInputType.visiblePassword,(p0) {
                    if(p0!.isEmpty){
                      return "Address can't be empty";
                    }

                    return null;
                  },
                  false,
                  AppProvider.user?.address,idx:4,
                onChanged: (value) {
                  cubit.addressController.text = value;
                },),

           Center(
             child: Visibility(
                 visible: cubit.is_change,
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 ElevatedButton(onPressed:()async{

                   if(keyform.currentState!.validate()==false){
                     return;
                   }
                   if(cubit.is_user_data_changed()&&cubit.is_password_changed_check()){
                     print("both");
                   await  cubit.update_both(cubit.nameController.text,cubit.emailController.text
                       ,cubit.phoneController.text,
                     AppProvider.user?.token??"",cubit.addressController.text,AppProvider.user?.pass??"",cubit.passwordController.text);
                   }
                   else if(cubit.is_user_data_changed()){
                     print("only data");
                    await cubit.updateUserData(cubit.nameController.text,cubit.emailController.text,
                      cubit.phoneController.text,AppProvider.user?.token??"",cubit.addressController.text);
                   }
                   else{
                     print("only pass");
                     cubit.updateUserPass(AppProvider.user?.pass??"",cubit.passwordController.text,AppProvider.user?.token??"");
                   }
                   setState(() {

                   });
                 },
                   style: ButtonStyle(
                     backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor),
                     shape: MaterialStateProperty.all(
                       RoundedRectangleBorder(
                         borderRadius: BorderRadius.circular(12),
                       )
                     )
                   ), child: Text("Save",style: TextStyle(
                   color: Colors.white,
                   fontSize: 16.sp,
                   fontFamily: "Poppins",
                   fontWeight: FontWeight.w500,
                 ))
                 ,
                 ),
                 SizedBox(
                   width: 10.w,
                 ),
                 ElevatedButton(onPressed:() {
                   setState(() {
                     cubit.passwordController.text=AppProvider.user?.pass??"";
                     cubit.emailController.text=AppProvider.user?.email??"";
                     cubit.nameController.text=AppProvider.user?.name??"";
                     cubit.addressController.text=AppProvider.user?.address??"";
                     cubit.phoneController.text=AppProvider.user?.phone??"";
                     for(int i=0;i<5;i++){
                       cubit.is_changes[i]=false;
                     }
                     cubit.is_change=false;
                   });
                 }, child: Text("Cancel",style: TextStyle(
                   color: Colors.white,
                   fontSize: 16.sp,
                   fontFamily: "Poppins",
                   fontWeight: FontWeight.w500,
                 ))
                 ,
                   style: ButtonStyle(
                     backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor),
                     shape: MaterialStateProperty.all(
                       RoundedRectangleBorder(
                         borderRadius: BorderRadius.circular(12),
                       )
                     )
                   ),
                 )
               ]
             )),
           ),
              SizedBox(
                height: 40.h,
              ),
              Container(
                margin:EdgeInsets.symmetric(horizontal: 8.w),
                child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                        MaterialStateProperty.all(Theme.of(context).primaryColor),
                        shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            )),
                        minimumSize: MaterialStateProperty.all(
                          Size(double.infinity, 60.h),
                        )),
                    onPressed:() async{
                      dialogUtilites.lottieLogOut(context,provider1);

                }, child: Text(
                  "Logout",style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w500,
                  ),
                )),
              ),
              SizedBox(height:15.h,)

            ]
          ),
        ),
      ),
    );
  }

}
