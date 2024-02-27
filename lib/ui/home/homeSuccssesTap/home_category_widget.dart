import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../../domain/model/Category.dart';
import 'package:ecommerce/ui/home/CategoriesTap/categoryProductsWidget.dart';

class HomeCategoryWidget extends StatelessWidget {
final Category category;
const HomeCategoryWidget(this.category, {super.key});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        PersistentNavBarNavigator.pushNewScreenWithRouteSettings(context,
            screen: const CategorProductsWidget(),
            withNavBar: true, settings:RouteSettings(name: CategorProductsWidget.routeName,
                arguments:category ));      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CachedNetworkImage(
            imageBuilder:(context, imageProvider) {
              return Container(
                width: 75.w,
                height: 75.h,
                  decoration: BoxDecoration(
                      borderRadius:BorderRadius.circular(45),
                      image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.fill,
                      )
                  )
              );
            },
            height: 75.h,
            width: 75.w,
            fit: BoxFit.cover,
            imageUrl: category.image??"",
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
          SizedBox(height: 5.h,),
          Text(category.name??"",style:  Theme.of(context).textTheme.titleMedium,)

        ],
      ),
    );
  }
}
