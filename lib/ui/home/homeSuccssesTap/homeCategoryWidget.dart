import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../../domain/model/Category.dart';
import 'package:ecommerce/ui/home/CategoriesTap/categoryProductsWidget.dart';

class homeCategoryWidget extends StatelessWidget {
Category category;
homeCategoryWidget(this.category);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        PersistentNavBarNavigator.pushNewScreenWithRouteSettings(context,
            screen: categorProductsWidget(),
            withNavBar: true, settings:RouteSettings(name: categorProductsWidget.routeName,
                arguments:category ));      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CachedNetworkImage(
            imageBuilder:(context, imageProvider) {
              return Container(
                  height: 65.h,
                  width: 65.w,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: imageProvider,

                          fit: BoxFit.cover,
                      )
                  )
              );
            },
            height: 65.h,
            width: 65.w,
            fit: BoxFit.cover,
            imageUrl: category.image??"",
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
          SizedBox(height: 5.h,),
          Text(category.name??"",style:  Theme.of(context).textTheme.titleMedium,)

        ],
      ),
    );
  }
}
