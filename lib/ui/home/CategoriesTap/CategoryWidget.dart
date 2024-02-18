import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ecommerce/ui/home/CategoriesTap/categoryProductsWidget.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../../domain/model/Category.dart';

class CategoryWidget extends StatefulWidget {
  Category category;
  CategoryWidget(this.category);

  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        PersistentNavBarNavigator.pushNewScreenWithRouteSettings(context,
          screen: categorProductsWidget(),
          withNavBar: true, settings:RouteSettings(name: categorProductsWidget.routeName,
              arguments:widget.category ));},
      child: Column(
        children: [
        Container(
          height:80.h,
          width: 80.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(color:Theme.of(context).primaryColor),
          ),
          child: CachedNetworkImage(
            imageUrl: widget.category.image??"",
            fit: BoxFit.cover,
            height: 70.h,
            width: 70.w,
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              )
            ),
            errorWidget: (context, url, error) => Icon(Icons.error),

          )
        ),

          Text(widget.category.name??"",style: Theme.of(context).textTheme.headlineSmall,
          maxLines:1,
          overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
