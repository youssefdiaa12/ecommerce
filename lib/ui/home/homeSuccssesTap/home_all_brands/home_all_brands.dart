import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../domain/model/Brand.dart';
import '../../homeLoadingTap/homeBrandLoadingWidget.dart';
import '../homeBrandWidget.dart';

class home_all_brands extends StatefulWidget {
  List<Brand> brands;
  home_all_brands(this.brands);
  @override
  State<home_all_brands> createState() => _home_all_brandsState();
}

class _home_all_brandsState extends State<home_all_brands> {
  @override
  Widget build(BuildContext context) {
    return widget.brands.isEmpty?Center(
      child: homeBrandLoadingWidget(),
    ):
        Scaffold(
          body: GridView.builder(gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ), itemBuilder:(context, index) {
            return Container(
              padding:EdgeInsets.symmetric(vertical: 25.h,horizontal:10.w),
                decoration:BoxDecoration(
                  borderRadius:BorderRadius.circular(25),
                  border:Border.all(color: const Color(0xffb2c5d9), width: 1),
                ),
                child: homeBrandWidget(widget.brands[index]));
          },
          itemCount: widget.brands.length,
          ),
        );
  }
}
