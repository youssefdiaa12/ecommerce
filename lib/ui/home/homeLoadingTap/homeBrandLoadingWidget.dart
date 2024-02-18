import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/domain/model/Brand.dart';
import 'package:flutter/material.dart';

import '../../../domain/model/Category.dart';

class homeBrandLoadingWidget extends StatelessWidget {

  homeBrandLoadingWidget();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 50,
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: const Color(0xff06004F),width: 1)
          )
        )
      ],
    );
  }
}
