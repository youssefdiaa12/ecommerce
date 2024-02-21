import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/domain/model/Brand.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../../domain/model/Category.dart';
import '../CategoriesTap/categoryProductsWidget.dart';

class homeBrandWidget extends StatelessWidget {
  Brand brand;
  homeBrandWidget(this.brand);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Category object = Category(
          id: brand.id,
          name: brand.name,
          image: brand.image,
          slug: brand.slug
        );
        PersistentNavBarNavigator.pushNewScreenWithRouteSettings(context,
            screen: categorProductsWidget(),
            withNavBar: true, settings:RouteSettings(name: categorProductsWidget.routeName,
                arguments:object ));

      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CachedNetworkImage(
            height: 50,
            width: double.infinity,
            fit: BoxFit.cover,
            imageUrl: brand.image??"",
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
          Text(brand.name??"",style:Theme.of(context).textTheme.titleMedium,maxLines: 2,
          overflow: TextOverflow.ellipsis,)

        ],
      ),
    );
  }
}
