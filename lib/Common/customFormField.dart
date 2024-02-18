import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
typedef Validator = String? Function(String?);
class CustomFormField extends StatefulWidget {
  TextEditingController a1;
  String hintText;
  TextInputType a2;
  bool is_icon;
  Validator? validtor;
  bool is_visable = true;
  int lines;
  String?labelText;
  bool is_loginOr_Register;

  CustomFormField(this.a1, this.hintText, this.a2, this.is_icon,this.validtor,this.labelText,{this.lines=1,this.is_loginOr_Register=false});

  @override
  State<CustomFormField> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  @override
  Widget build(BuildContext context) {

    return

      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.labelText??"",style: TextStyle(color: Colors.white),),
            SizedBox(height: 10.h,),
            TextFormField(
              maxLines: widget.lines,
              minLines: 1,
              validator: widget.validtor,
              obscureText: widget.is_icon ? widget.is_visable : false,
              keyboardType: widget.a2,
              controller: widget.a1,
              decoration: InputDecoration(
                hintStyle: TextStyle(color: Colors.grey.shade500,
                ),

                contentPadding: EdgeInsets.symmetric(vertical: 17.0.h,horizontal:10.w), // Adjust the vertical padding here
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                gapPadding: 10,
                ),
                filled: true,
                fillColor: Colors.white,
                labelText: widget.hintText,
                labelStyle: TextStyle(color: Colors.grey.shade500),
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                suffixIcon: widget.is_icon
                    ? InkWell(
                  onTap: () {
                    setState(() {
                      widget.is_visable = !widget.is_visable;
                    });
                  },
                  child:widget.is_visable?
                  const Icon(
                    Icons.visibility_off,
                    color: Colors.grey,
                  ):
                  const Icon(
                    Icons.remove_red_eye,
                    color: Colors.grey,
                  ),
                )
                    : null,
              ),
              style:  TextStyle(color:Colors.black),
            ),
          ],
        ),
      );
  }
}
