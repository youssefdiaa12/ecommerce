import 'package:ecommerce/ui/home/homeLoadingTap/homeCategoryLoadingWidget.dart';
import 'package:ecommerce/ui/home/homeSuccssesTap/homeCategoryWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../domain/model/Category.dart';

class home_all_categories extends StatefulWidget {
  List<Category> categories=[];
  home_all_categories(this.categories);
  @override
  State<home_all_categories> createState() => _home_all_categoriesState();
}

class _home_all_categoriesState extends State<home_all_categories> {
  @override
  Widget build(BuildContext context) {
         return widget.categories.isEmpty?Center(
      child: homeCategoryLoadingWidget(),
    ):
    Scaffold(
      body: Padding(
        padding:  EdgeInsets.only(top: 10.0.h),
        child: GridView.builder(gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ), itemBuilder:(context, index) {
          return homeCategoryWidget(widget.categories[index]);
        },
          itemCount: widget.categories.length,
        ),
      ),
    );
  }
  }

