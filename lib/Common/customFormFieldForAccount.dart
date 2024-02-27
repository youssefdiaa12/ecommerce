import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../viewModel/updateUserDataViewModel/update_user_data_cubit.dart';
typedef Validator = String? Function(String?);
typedef ValueChangedCallback = void Function(String);
class customFormFieldForAccount extends StatefulWidget {
  TextEditingController textController;
  String hintText;
  TextInputType a2;
  Validator? validtor;
  bool is_visable = true;
  int lines;
  String?labelText;
  int idx;
  final ValueChangedCallback onChanged;

  customFormFieldForAccount(this.textController, this.hintText, this.a2,this.validtor,this.is_visable,this.labelText,{this.lines=1,this.idx=0,
  required this.onChanged});

  @override
  State<customFormFieldForAccount> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<customFormFieldForAccount> {
  bool is_visable_2=false;
  int idx=0;

  void changedd(){
    widget.textController.addListener(() {
      // Store the current cursor position
      setState(() {
        idx = widget.textController.selection.base.offset;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    changedd();
  }
  @override
  Widget build(context) {
    var cubit = BlocProvider.of<UpdateUserDataCubit>(context);

    return
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: TextFormField(
          readOnly: !cubit.is_changes[widget.idx],
          obscureText: widget.is_visable == true ? !is_visable_2 : widget.is_visable,
          controller: widget.textController,
          validator: widget.validtor,
          // onChanged: (value) {widget.onChanged(value);
          //   int newPosition = idx + (value.length - widget.textController.text.length);
          //   // Set cursor position to the new position
          //   widget.textController.selection = TextSelection.collapsed(offset: newPosition);
          //   //    widget.textController.text = value;
          // },
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xff8e8bae),width:1), // Set your desired border color here
              borderRadius: BorderRadius.circular(12),
              gapPadding: 10,
            ),
            border:OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xff8e8bae),width:1),
              borderRadius: BorderRadius.circular(12),
              gapPadding: 10,
            ),

            suffixIcon:Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                widget.is_visable==true?Padding(
                  padding:  EdgeInsets.only(right: 4.0.w),
                  child: InkWell(
                    onTap: (){
                      setState(() {
                        is_visable_2=!is_visable_2;
                      });
                    },
                    child:Icon(
                      is_visable_2==true?Icons.visibility:Icons.visibility_off,
                      color:Theme.of(context).primaryColor,
                    ),
                  ),
                ):Container(width: 0),
                InkWell(
                    onTap: (){
                      setState(() {
                        cubit.is_changes[widget.idx]=!cubit.is_changes[widget.idx];
                        cubit.is_change=false;
                        for(var i in cubit.is_changes){
                          if(i==true){
                            cubit.is_change=true;
                          }
                        }
                        cubit.update();
                        print("cubit.is_changes[widget.idx]${cubit.is_changes[widget.idx]}");
                      });
                    },
                    child: Image.asset("assets/icons/edit.png")),
                widget.is_visable==true?Padding(
                  padding:  EdgeInsets.only(left: 4.0.w),
                ):Container(width: 0),
              ],
            ),
            hintText: "${widget.hintText}",
          ),

        ),
      );
  }
}











