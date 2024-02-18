import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/domain/model/Brand.dart';
import 'package:flutter/material.dart';

import '../../../domain/model/Category.dart';

class homeBrandWidget extends StatelessWidget {
  Brand brand;
  homeBrandWidget(this.brand);
  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
  }
}
